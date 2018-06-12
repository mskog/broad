class Episode < ActiveRecord::Base
  belongs_to :tv_show, touch: true
  has_many :releases, class_name: "EpisodeRelease", dependent: :destroy

  serialize :tmdb_details, Hash

  after_commit :fetch_details, :on => :create

  before_create :add_key

  scope :downloadable, -> {where("episodes.download_at < current_timestamp")}
  scope :with_release, -> {where("episodes.id IN (SELECT episode_id from episode_releases)")}

  # TODO Use download_at
  def downloadable?
    DateTime.now >= download_at
  end

  private

  def fetch_details
    FetchEpisodeDetailsJob.perform_later self
  end

  def add_key
    self.key = SecureRandom.urlsafe_base64
  end
end
