class Episode < ActiveRecord::Base
  belongs_to :tv_show, touch: true
  has_many :releases, class_name: "EpisodeRelease", dependent: :destroy

  serialize :tmdb_details, Hash

  after_commit :fetch_details, :on => :create

  before_create :add_key

  scope :downloadable, ->{where("episodes.download_at < current_timestamp")}
  scope :with_release, ->{where("episodes.id IN (SELECT episode_id from episode_releases)")}
  scope :without_release, ->{where("episodes.id NOT IN (SELECT episode_id from episode_releases)")}
  scope :unwatched, ->{where("episodes.watched = false")}
  scope :aired, ->(date = Date.today){where("episodes.air_date IS NOT NULL AND episodes.air_date <= ?", date)}
  scope :unaired, ->(date = Date.today){where("episodes.air_date NULL OR episodes.air_date >= ?", date)}

  # TODO: Use download_at
  def downloadable?
    DateTime.now >= download_at
  end

  def releases?
    releases.any?
  end

  private

  def fetch_details
    FetchEpisodeDetailsJob.perform_later self
  end

  def add_key
    self.key = SecureRandom.urlsafe_base64
  end
end
