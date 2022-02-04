class Movie < ApplicationRecord
  include Base64Images
  include PgSearch::Model

  multisearchable against: [:title]

  has_many :releases, class_name: "MovieRelease", dependent: :destroy, autosave: true
  has_many :news_items, as: :newsworthy, dependent: :destroy

  before_create :add_key

  after_commit :fetch_details, :on => :create

  scope :downloadable, ->{where("(waitlist = false AND download_at IS NULL) OR download_at < current_timestamp")}
  scope :on_waitlist, ->{where("waitlist = true AND (download_at IS NULL OR download_at > current_timestamp)")}
  scope :watched, ->{where(watched: true)}

  scope :upcoming, ->{where("waitlist = true AND download_at IS NULL AND available_date is not null and available_date > current_date and available_date <= ?", 90.days.from_now)}

  base64_image :backdrop_image, :poster_image

  def deletable?
    waitlist? && (download_at.blank? || download_at >= DateTime.now)
  end

  def fetch_images
    update tmdb_images: Tmdb::Movie.images(imdb_id)
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

  private

  def has_release?(ptp_release)
    releases.find_by(ptp_movie_id: ptp_release.id)
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
