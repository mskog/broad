# typed: strict

class Movie < ApplicationRecord
  include Base64Images
  include PgSearch::Model

  multisearchable against: [:title]

  has_many :releases, class_name: "MovieRelease", dependent: :destroy, autosave: true
  has_many :news_items, as: :newsworthy, dependent: :destroy
  has_many :release_dates, class_name: "MovieReleaseDate", dependent: :destroy

  before_create :add_key

  after_commit :fetch_details, :on => :create
  after_commit on: :create do
    FetchMovieReleaseDatesJob.perform_later self
  end

  scope :downloadable, (lambda do
    where("(waitlist = false AND download_at IS NULL) OR download_at < current_timestamp")
    .includes(:releases)
    .order(Arel.sql("download_at IS NOT NULL DESC, download_at desc, id desc"))
  end)
  scope :on_waitlist, ->{where("waitlist = true AND (download_at IS NULL OR download_at > current_timestamp)")}
  scope :watched, ->{where(watched: true)}
  scope :unwatched, ->{where(watched: false)}

  scope :upcoming, (lambda do
    unwatched
    .where("movies.id IN (select movie_id from movie_release_dates where release_date > current_timestamp)")
    .where("release_date >= ?", 2.years.ago)
  end)

  scope :with_better_release_than_downloaded, (lambda do
    where.not(id: MovieRelease.where(resolution: "2160p", downloaded: true, source: "blu-ray").select(:movie_id))
    .where(watched: false)
    .where("download_at >= ?", 12.months.ago)
  end)

  base64_image :backdrop_image, :poster_image

  sig{void}
  def self.check_for_better_releases_than_downloaded
    with_better_release_than_downloaded.each do |movie|
      movie.check_for_better_releases_than_downloaded

      # TODO: Replace with some kind of rate limiter
      sleep 10 unless Rails.env.to_sym == :test
    end
  end

  sig{void}
  def check_for_better_releases_than_downloaded
    fetch_new_releases
    save
    if has_better_release_than_downloaded?
      update(download_at: DateTime.now)

      # TODO: Change message to include quality of release
      NotifyHuginnJob.perform_later "A better release for #{title} has been found and will be downloaded."
    end
  end

  sig{returns(T.nilable(String))}
  def download
    release = best_release
    return if release.blank?
    best_release.update downloaded: true
    best_release.download_url
  end

  sig{void}
  def fetch_images
    update tmdb_images: Tmdb::Movie.images(imdb_id)
  end

  sig{void}
  def fetch_new_releases
    return if ptp_movie.blank?
    ptp_movie_releases = ptp_movie.releases

    ptp_movie_releases.each do |ptp_release|
      existing_release = releases.find do |release|
        release.ptp_movie_id == ptp_release.id
      end

      release = existing_release || releases.build(ptp_movie_id: ptp_release.id, auth_key: ptp_movie.auth_key)
      release.attributes = ptp_release.to_h.except(:id)
    end

    self.releases = releases.select do |release|
      ptp_movie_releases.map(&:id).include?(release.ptp_movie_id)
    end
  end

  # TODO: Refactoring opportunity. This is kind of gunky
  sig{void}
  def fetch_release_dates
    qualities = ["Unknown", "Digital HD", "Blu-ray", "4K UHD"]
    struct = Struct.new(:release_date, :release_type, :quality)

    release_dates.delete_all

    data = Services::N8n::Api.new.release_dates(title)

    data.map do |item|
      type = if item.type.include? "4K UHD"
               "4K UHD"
             elsif item.type.include? "Blu-ray"
               "Blu-ray"
             elsif item.type.include? "Digital HD"
               "Digital HD"
             else
               "Unknown"
             end

      quality = qualities.index(type)

      struct.new(item.release_date, type, quality)
    end.uniq.group_by(&:release_date).flat_map do |_type, group|
      group.max_by(&:quality)
    end.each do |item|
      release_dates.create(release_date: item.release_date, release_type: item.release_type)
    end

    update available_date: release_dates.minimum(:release_date)
  end

  # TODO: Refactor
  sig{returns(T::Boolean)}
  def has_better_release_than_downloaded?
    downloaded_release = best_release(&:downloaded?)
    return true if downloaded_release.blank? && acceptable_releases.any?
    better_source = downloaded_release.try(:source_points).to_i < best_release.try(:source_points).to_i
    better_resolution = downloaded_release.try(:resolution_points).to_i < best_release.try(:resolution_points).to_i
    equal_resolution = downloaded_release.try(:resolution_points).to_i <= best_release.try(:resolution_points).to_i

    better_resolution || (equal_resolution && better_source)
  end

  sig{returns(T::Boolean)}
  def deletable?
    waitlist? && (download_at.blank? || T.must(download_at) >= DateTime.now)
  end

  sig{params(size: Integer).returns(T.nilable(String))}
  def poster_image(size = 1280)
    return nil unless tmdb_images.key?("posters") && tmdb_images["posters"].any?
    image = tmdb_images["posters"][0]["file_path"]
    "#{Broad.tmdb_configuration.secure_base_url}w#{size}/#{image}"
  end

  sig{returns(T.nilable(String))}
  def backdrop_image
    return nil unless tmdb_images.key?("backdrops") && tmdb_images["backdrops"].any?
    image = best_image(tmdb_images["backdrops"])["file_path"]
    "#{Broad.tmdb_configuration.secure_base_url}original#{image}"
  end

  sig{returns(T.untyped)}
  def ptp_movie
    @ptp_movie ||= T.let(ptp_api.search(imdb_id).movie, T.untyped)
  end

  sig{params(rule_klass: T.untyped, block: T.nilable(T.proc.params(arg0: MovieRelease).void)).returns(T::Array[T.untyped])}
  def acceptable_releases(rule_klass: Domain::Ptp::ReleaseRules::Default, &block)
    Domain::AcceptableReleases.new(releases, rule_klass: rule_klass).select do |release|
      block.present? ? (yield release) : true
    end
  end

  sig{params(rule_klass: T.untyped, block: T.proc.params(arg0: MovieRelease).void).returns(T::Array[T.untyped])}
  def waitlist_releases(rule_klass: Domain::Ptp::ReleaseRules::Waitlist, &block)
    Domain::AcceptableReleases.new(releases, rule_klass: rule_klass).select do |release|
      block.present? ? (yield release) : true
    end
  end

  sig{params(rule_klass: T.untyped).returns(Domain::AcceptableReleases)}
  def killer_releases(rule_klass: Domain::Ptp::ReleaseRules::Killer)
    Domain::AcceptableReleases.new(releases, rule_klass: rule_klass)
  end

  sig{params(block: T.nilable(T.proc.params(arg0: MovieRelease).void)).returns(T::Boolean)}
  def has_acceptable_release?(&block)
    acceptable_releases(&block).any?
  end

  sig{params(block: T.proc.params(arg0: MovieRelease).void).returns(T::Boolean)}
  def has_waitlist_release?(&block)
    waitlist_releases(&block).any?
  end

  sig{returns(T::Boolean)}
  def has_killer_release?
    killer_releases.any?
  end

  sig{params(rule_klass: T.untyped, block: T.nilable(T.proc.params(arg0: MovieRelease).void)).returns(T.untyped)}
  def best_release(rule_klass: Domain::Ptp::ReleaseRules::Default, &block)
    acceptable_releases(rule_klass: rule_klass, &block).max
  end

  private

  # Not used
  sig{params(ptp_release: T.untyped).returns(T.untyped)}
  def has_release?(ptp_release)
    releases.find_by(ptp_movie_id: ptp_release.id).present?
  end

  sig{params(images: T.untyped).returns(T.untyped)}
  def best_image(images)
    images_4k = images.select{|image| image["width"] == 3840}
    images_4k.first || images.first
  end

  sig{void}
  def add_key
    self.key = SecureRandom.urlsafe_base64
  end

  sig{void}
  def fetch_details
    FetchMovieDetailsJob.perform_later self
    FetchMovieImagesJob.perform_later self
  end

  sig{returns(Services::Ptp::Api)}
  def ptp_api
    Services::Ptp::Api.new
  end
end
