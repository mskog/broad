class Episode < ActiveRecord::Base
  belongs_to :tv_show
  has_many :releases, class_name: EpisodeRelease

  after_commit :fetch_details, :on => :create

  before_create :add_key

  private

  def fetch_details
    FetchEpisodeDetailsJob.perform_later self
  end

  def add_key
    self.key = SecureRandom.urlsafe_base64
  end
end
