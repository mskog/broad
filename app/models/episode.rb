class Episode < ApplicationRecord
  include Base64Images
  include Routeable

  belongs_to :tv_show, touch: true
  has_many :releases, class_name: "EpisodeRelease", dependent: :destroy

  serialize :tmdb_details, Hash

  before_create :add_key
  after_commit :fetch_details, :on => :create

  scope :downloadable, ->{where("episodes.download_at < current_timestamp")}
  scope :with_release, ->{where("episodes.id IN (SELECT episode_id from episode_releases)")}
  scope :without_release, ->{where("episodes.id NOT IN (SELECT episode_id from episode_releases)")}
  scope :with_distinct_releases, ->{where("episodes.id IN (SELECT distinct on (episode_releases.url) episode_releases.episode_id FROM episode_releases ORDER BY episode_releases.url, episode_releases.episode_id)")}
  scope :unwatched, ->{where("episodes.watched = false")}
  scope :watched, ->{where("episodes.watched = true")}
  scope :aired, ->(date = Time.zone.today){where("episodes.air_date IS NOT NULL AND episodes.air_date <= ?", date)}
  scope :unaired, ->(date = Time.zone.today){where("episodes.air_date NULL OR episodes.air_date >= ?", date)}

  base64_image :still_image

  # TODO: Use download_at
  def downloadable?
    DateTime.now >= download_at
  end

  def releases?
    releases.any?
  end

  def still_image(size = "original")
    "#{Broad.tmdb_configuration.secure_base_url}#{size}#{tmdb_still}" if tmdb_still
  end

  private

  def fetch_details
    FetchEpisodeDetailsJob.perform_later self
  end

  def add_key
    self.key = SecureRandom.urlsafe_base64
  end

  # TODO: Eww
  def tmdb_still
    tmdb_details.try(:fetch, "still_path", nil) || tv_show.tmdb_details.try(:fetch, "backdrop_path", nil)
  end

  def murray
    ActionController::Base.helpers.image_url("murray_300x169.jpg")
  end
end
