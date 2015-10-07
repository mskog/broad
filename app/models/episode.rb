class Episode < ActiveRecord::Base
  has_many :releases, class_name: EpisodeRelease

  before_create :add_key

  private

  def add_key
    self.key = SecureRandom.urlsafe_base64
  end
end
