class Movie < ActiveRecord::Base
  has_many :releases, class_name: "MovieRelease", dependent: :destroy, autosave: true
  has_many :news_items, as: :newsworthy

  before_create :add_key

  after_commit :fetch_details, :on => :create

  scope :downloadable, ->{where("(waitlist = false AND download_at IS NULL) OR download_at < current_timestamp")}
  scope :on_waitlist, ->{where("waitlist = true AND (download_at IS NULL OR download_at > current_timestamp)")}
  scope :watched, ->{where(watched: true)}

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
    image = tmdb_images["backdrops"][0]["file_path"]
    "#{Broad.tmdb_configuration.secure_base_url}w1280#{image}"
  end

  private

  def add_key
    self.key = SecureRandom.urlsafe_base64
  end

  def fetch_details
    FetchMovieDetailsJob.perform_later self
    FetchMovieImagesJob.perform_later self
  end
end
