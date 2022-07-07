# typed: strict

class Episode < ApplicationRecord
  extend T::Sig

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

  sig{params(tv_show: TvShow, entry: T.untyped).returns(Episode)}
  def self.create_from_entry(tv_show, entry)
    entry_attributes = entry.slice(:name, :episode, :year)
    entry_attributes[:season_number] = entry[:season]
    entry_attributes[:name].try(:strip!)

    episode = tv_show.episodes.find_or_create_by(episode: entry_attributes[:episode], season_number: entry[:season]) do |ep|
      ep.name = entry[:name]
      ep.year = entry[:year]
      ep.published_at = entry[:published_at]
    end

    release_attributes = entry.except(:name, :episode, :year, :season)
    release_attributes[:title].strip!

    episode.releases.find_or_initialize_by(release_attributes)
    episode.save!
    episode.update_download_at
  end

  sig{returns(T.nilable(String))}
  def download
    release = best_release
    return if release.blank?

    release.update downloaded: true
    T.must(release.episode).update downloaded: true
    T.must(T.must(release.episode).season).update downloaded: T.must(T.must(release.episode).season).episodes.all?(&:downloaded?)
    release.url
  end

  sig{returns(Episode)}
  def update_download_at
    return self if releases.empty?
    return self if watched?
    return self if download_at.present? && T.must(download_at) < 1.week.ago

    release = best_release
    return self if release.blank?

    downloaded_release = releases.sort.reverse.find(&:downloaded?)
    better_available = downloaded_release.try(:resolution_points).to_i < release.resolution_points

    self.download_at = better_available ? Time.zone.now : download_at || Time.zone.now
    save!
    self
  end

  sig{returns(T::Boolean)}
  def downloadable?
    DateTime.now >= download_at
  end

  sig{returns(T::Boolean)}
  def aired?
    air_date.present? ? T.must(air_date) <= Time.zone.today : false
  end

  sig{returns(T.nilable(EpisodeRelease))}
  def best_release
    releases.sort.reverse.first
  end

  sig{params(size: String).returns(T.nilable(String))}
  def still_image(size = "original")
    "#{Broad.tmdb_configuration.secure_base_url}#{size}#{tmdb_still}" if tmdb_still
  end

  private

  sig{returns(T.any(FetchEpisodeDetailsJob, FalseClass))}
  def fetch_details
    FetchEpisodeDetailsJob.perform_later self
  end

  sig{returns(Season)}
  def add_season
    self.season = Season.find_or_create_by(tv_show_id: tv_show_id, number: season_number)
  end

  sig{returns(String)}
  def add_key
    self.key = SecureRandom.urlsafe_base64
  end

  # TODO: Eww
  sig{returns(String)}
  def tmdb_still
    tmdb_details.try(:fetch, "still_path", nil) || T.must(tv_show).tmdb_details.try(:fetch, "backdrop_path", nil)
  end

  sig{returns(String)}
  def murray
    ActionController::Base.helpers.image_url("murray_300x169.jpg")
  end
end
