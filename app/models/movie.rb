class Movie < ActiveRecord::Base
  has_many :releases, class_name: "MovieRelease", dependent: :destroy, autosave: true

  has_one_attached :poster_image
  has_one_attached :backdrop_image

  before_create :add_key

  after_commit :fetch_details, :on => :create

  scope :downloadable, ->{where("(waitlist = false AND download_at IS NULL) OR download_at < current_timestamp")}
  scope :on_waitlist, ->{where("waitlist = true AND (download_at IS NULL OR download_at > current_timestamp)")}
  scope :watched, ->{where(watched: true)}

  def deletable?
    waitlist? && (!download_at.present? || download_at >= DateTime.now)
  end

  def fetch_images
    images = Tmdb::Movie.images(imdb_id)
    if images.key?("posters") && images["posters"].any?
      image = images["posters"][0]["file_path"]
      url = "#{Broad.tmdb_configuration.secure_base_url}original#{image}"
      filename = File.basename(URI.parse(url).path)
      file = URI.open(url)
      poster_image.attach(io: file, filename: filename)
    end

    if images.key?("backdrops") && images["backdrops"].any?
      image = images["backdrops"][0]["file_path"]
      url = "#{Broad.tmdb_configuration.secure_base_url}original#{image}"
      filename = File.basename(URI.parse(url).path)
      file = URI.open(url)
      backdrop_image.attach(io: file, filename: filename)
    end
  end

  private

  def add_key
    self.key = SecureRandom.urlsafe_base64
  end

  def fetch_details
    FetchMovieDetailsJob.perform_later self
    FetchRtRatingsJob.perform_later self
    FetchMovieImagesJob.perform_later self
  end
end
