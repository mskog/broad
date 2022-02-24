class Movie < ApplicationRecord
  include Base64Images
  include PgSearch::Model

  multisearchable against: [:title]

  has_many :releases, class_name: "MovieRelease", dependent: :destroy, autosave: true
  has_many :news_items, as: :newsworthy, dependent: :destroy

  before_create :add_key

  after_commit :fetch_details, :on => :create

  scope :downloadable, ->{where("(waitlist = false AND download_at IS NULL) OR download_at < current_timestamp").includes(:releases).order(Arel.sql("download_at IS NOT NULL DESC, download_at desc, id desc"))}
  scope :on_waitlist, ->{where("waitlist = true AND (download_at IS NULL OR download_at > current_timestamp)")}
  scope :watched, ->{where(watched: true)}

  scope :upcoming, ->{where("waitlist = true AND download_at IS NULL AND available_date is not null and available_date > current_date and available_date <= ?", 90.days.from_now)}

  base64_image :backdrop_image, :poster_image

  def download
    release = best_release
    return if release.blank?
    best_release.update downloaded: true
    best_release.download_url
  end

  def fetch_images
    update tmdb_images: Tmdb::Movie.images(imdb_id)
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
