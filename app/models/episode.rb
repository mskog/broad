class Episode < ApplicationRecord
  include Base64Images
  include Routeable

  belongs_to :tv_show, touch: true

  belongs_to :season

  has_many :releases, class_name: "EpisodeRelease", dependent: :destroy

  before_create :add_key
  before_create :add_season
  after_create :fetch_details

  scope :downloaded, ->{where(downloaded: true)}
  scope :downloadable, ->{where("episodes.download_at < current_timestamp")}
  scope :with_release, ->{where("episodes.id IN (SELECT episode_id from episode_releases)")}
  scope :without_release, ->{where("episodes.id NOT IN (SELECT episode_id from episode_releases)")}
  scope :with_distinct_releases, ->{where("episodes.id IN (SELECT distinct on (episode_releases.url) episode_releases.episode_id FROM episode_releases ORDER BY episode_releases.url, episode_releases.episode_id)")}
  scope :unwatched, ->{where("episodes.watched = false")}
  scope :watched, ->{where("episodes.watched = true")}
  scope :aired, ->(date = Time.zone.today){where("episodes.air_date IS NOT NULL AND episodes.air_date <= ?", date)}
  scope :unaired, ->(date = Time.zone.today){where("episodes.air_date NULL OR episodes.air_date >= ?", date)}

  base64_image :still_image

  def download
    release = best_release
    return if release.blank?
    best_release.update downloaded: true
    best_release.episode.update downloaded: true
    best_release.episode.season.update downloaded: best_release.episode.season.episodes.all?(&:downloaded?)
    best_release.url
  end

  def update_download_at
    return self if releases.empty?
    return self if watched?
    return self if download_at.present? && download_at < 1.week.ago

    downloaded_release = releases.sort.reverse.find(&:downloaded?)
    better_available = downloaded_release.try(:resolution_points).to_i < best_release.resolution_points

    self.download_at = better_available ? Time.zone.now : download_at || Time.zone.now
    save!
    self
  end

  def downloadable?
    DateTime.now >= download_at
  end

  def aired?
    air_date.present? ? air_date <= Time.zone.today : false
  end

  def best_release
    releases.sort.reverse.first
  end

  def still_image(size = "original")
    "#{Broad.tmdb_configuration.secure_base_url}#{size}#{tmdb_still}" if tmdb_still
  end

  private

  def fetch_details
    FetchEpisodeDetailsJob.perform_later self
  end

  def add_season
    self.season = Season.find_or_create_by(tv_show_id: tv_show_id, number: season_number)
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
