class Movie < ApplicationRecord
  include Base64Images
  include PgSearch::Model

  multisearchable against: [:title]

  has_many :releases, class_name: "MovieRelease", dependent: :destroy, autosave: true
  has_many :news_items, as: :newsworthy, dependent: :destroy

  before_create :add_key

  after_commit :fetch_details, :on => :create

  scope :downloadable, (lambda do
    where("(waitlist = false AND download_at IS NULL) OR download_at < current_timestamp")
    .includes(:releases)
    .order(Arel.sql("download_at IS NOT NULL DESC, download_at desc, id desc"))
  end)
  scope :on_waitlist, ->{where("waitlist = true AND (download_at IS NULL OR download_at > current_timestamp)")}
  scope :watched, ->{where(watched: true)}

  scope :upcoming, (lambda do
    where("waitlist = true AND download_at IS NULL")
    .where("available_date is not null and available_date > current_date and available_date <= ?", 90.days.from_now)
  end)

  scope :with_better_release_than_downloaded, (lambda do
    where.not(id: MovieRelease.where(resolution: "2160p", downloaded: true, source: "blu-ray").select(:movie_id))
    .where(watched: false)
    .where("download_at >= ?", 12.months.ago)
  end)

  base64_image :backdrop_image, :poster_image

  def self.check_for_better_releases_than_downloaded
    with_better_release_than_downloaded.each do |movie|
      movie.check_for_better_releases_than_downloaded

      # TODO: Replace with some kind of rate limiter
      sleep 10 unless Rails.env.test?
    end
  end

  def check_for_better_releases_than_downloaded
    fetch_new_releases
    save
    if has_better_release_than_downloaded?
      update(download_at: DateTime.now)

      # TODO: Change message to include quality of release
      NotifyHuginnJob.perform_later "A better release for #{title} has been found and will be downloaded."
    end
  end

  def download
    release = best_release
    return if release.blank?
    best_release.update downloaded: true
    best_release.download_url
  end

  def fetch_images
    update tmdb_images: Tmdb::Movie.images(imdb_id)
  end

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

  # TODO: Refactor
  def has_better_release_than_downloaded?
    downloaded_release = best_release(&:downloaded?)
    return true if downloaded_release.blank? && acceptable_releases.any?
    better_source = downloaded_release.try(:source_points).to_i < best_release.try(:source_points).to_i
    better_resolution = downloaded_release.try(:resolution_points).to_i < best_release.try(:resolution_points).to_i
    equal_resolution = downloaded_release.try(:resolution_points).to_i <= best_release.try(:resolution_points).to_i

    better_resolution || (equal_resolution && better_source)
  end

  def deletable?
    waitlist? && (download_at.blank? || download_at >= DateTime.now)
  end

  def poster_image(size = 1280)
    return nil unless tmdb_images.key?("posters") && tmdb_images["posters"].any?
    image = tmdb_images["posters"][0]["file_path"]
    "#{Broad.tmdb_configuration.secure_base_url}w#{size}/#{image}"
  end

  def backdrop_image
    return nil unless tmdb_images.key?("backdrops") && tmdb_images["backdrops"].any?
    image = best_image(tmdb_images["backdrops"])["file_path"]
    "#{Broad.tmdb_configuration.secure_base_url}original#{image}"
  end

  def ptp_movie
    @ptp_movie ||= ptp_api.search(imdb_id).movie
  end

  def acceptable_releases(rule_klass: Domain::Ptp::ReleaseRules::Default)
    Domain::AcceptableReleases.new(releases, rule_klass: rule_klass).select do |release|
      block_given? ? (yield release) : true
    end
  end

  def waitlist_releases(rule_klass: Domain::Ptp::ReleaseRules::Waitlist)
    Domain::AcceptableReleases.new(releases, rule_klass: rule_klass).select do |release|
      block_given? ? (yield release) : true
    end
  end

  def killer_releases(rule_klass: Domain::Ptp::ReleaseRules::Killer)
    Domain::AcceptableReleases.new(releases, rule_klass: rule_klass)
  end

  def has_acceptable_release?(&block)
    acceptable_releases(&block).any?
  end

  def has_waitlist_release?(&block)
    waitlist_releases(&block).any?
  end

  def has_killer_release?
    killer_releases.any?
  end

  def best_release(rule_klass: Domain::Ptp::ReleaseRules::Default, &block)
    acceptable_releases(rule_klass: rule_klass, &block).max
  end

  private

  # Not used
  def has_release?(ptp_release)
    releases.find_by(ptp_movie_id: ptp_release.id).present?
  end

  def best_image(images)
    images_4k = images.select{|image| image["width"] == 3840}
    images_4k.first || images.first
  end

  def add_key
    self.key = SecureRandom.urlsafe_base64
  end

  def fetch_details
    FetchMovieDetailsJob.perform_later self
    FetchMovieImagesJob.perform_later self
  end

  def ptp_api
    @ptp_api ||= Services::Ptp::Api.new
  end
end
