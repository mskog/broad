class Episode < ActiveRecord::Base
  belongs_to :tv_show
  has_many :releases, class_name: EpisodeRelease, dependent: :destroy

  serialize :tmdb_details

  after_commit :fetch_details, :on => :create

  before_create :add_key

  scope :downloadable, -> {where("download_at < current_timestamp")}

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
