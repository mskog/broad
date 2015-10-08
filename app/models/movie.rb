class Movie < ActiveRecord::Base
  has_many :releases, class_name: MovieRelease, dependent: :destroy, autosave: true

  before_create :add_key

  after_create :fetch_details

  private

  def add_key
    self.key = SecureRandom.urlsafe_base64
  end

  def fetch_details
    FetchMovieDetailsJob.perform_later self
  end
end
