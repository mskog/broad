class Movie < ActiveRecord::Base
  has_many :movie_releases, dependent: :destroy, autosave: true

  before_create :add_key

  private

  def add_key
    self.key = SecureRandom.urlsafe_base64
  end
end
