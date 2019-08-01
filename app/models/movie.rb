class Movie < ActiveRecord::Base
  has_many :releases, class_name: "MovieRelease", dependent: :destroy, autosave: true

  before_create :add_key

  after_commit :fetch_details, :on => :create

  scope :downloadable, ->{where("(waitlist = false AND download_at IS NULL) OR download_at < current_timestamp")}
  scope :on_waitlist, ->{where("waitlist = true AND (download_at IS NULL OR download_at > current_timestamp)")}
  scope :watched, ->{where(watched: true)}

  def deletable?
    waitlist? && (!download_at.present? || download_at >= DateTime.now)
  end

  private

  def add_key
    self.key = SecureRandom.urlsafe_base64
  end

  def fetch_details
    FetchMovieDetailsJob.perform_later self
    FetchRtRatingsJob.perform_later self
  end
end
