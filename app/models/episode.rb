class Episode < ApplicationRecord
  include Base64Images
  include Routeable

  belongs_to :tv_show, touch: true

  belongs_to :season

  has_many :releases, class_name: "EpisodeRelease", dependent: :destroy

  before_create :add_key
  before_commit :add_season, :on => :create
  after_commit :fetch_details, :on => :create

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

  def download
    release = best_available_release
    return if release.blank?
    best_available_release.update downloaded: true
    best_available_release.episode.update downloaded: true
    best_available_release.episode.season.update downloaded: best_available_release.episode.season.episodes.all?(&:downloaded?)
    best_available_release.url
  end

  def download_delay
    return nil if releases.empty?
    has_killer_release? || !releasing_in_4k? ? 0 : ENV["DELAY_HOURS"].to_i
  end

  # TODO: Refactor
  # TODO: Can this be moved?
  def get_download_at
    return nil if releases.empty?

    downloaded_release = comparable_releases.sort.reverse.find(&:downloaded?)
    better_available = !watched? && downloaded_release.try(:resolution_points).to_i < best_release.resolution_points

    download = better_available ? Time.zone.now : download_at
    delay = DateTime.now + download_delay.hours
    return delay unless download.present? && download < delay
    download
  end

  def best_release
    comparable_releases.sort.reverse.first
  end

  # TODO: will return nil if no release exists
  # TODO: This is equivalent to best_release. Why?
  def best_available_release
    comparable_releases.sort.reverse.first
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

  def has_killer_release?
    best_release.killer?
  end

  def releasing_in_4k?
    return true unless tv_show.episodes.size > 1

    tv_show.episodes.any? do |episode|
      episode.best_available_release.try(:resolution) == "2160p"
    end
  end

  # TODO: Eww
  def tmdb_still
    tmdb_details.try(:fetch, "still_path", nil) || tv_show.tmdb_details.try(:fetch, "backdrop_path", nil)
  end

  def murray
    ActionController::Base.helpers.image_url("murray_300x169.jpg")
  end

  def comparable_releases
    releases.map do |release|
      Domain::Btn::Release.new(release)
    end
  end
end
