class TvShow < ApplicationRecord
  include Base64Images

  include PgSearch::Model

  multisearchable against: [:name]

  after_commit :fetch_details, :on => :create

  has_many :seasons, dependent: :destroy
  has_many :episodes, dependent: :destroy
  has_many :news_items, as: :newsworthy, dependent: :destroy

  scope :watching, ->{where("waitlist = false AND (status = 'returning series' OR status IS NULL)").where(watching: true)}
  scope :not_watching, ->{where("waitlist = false AND (status = 'returning series' OR status IS NULL)").where(watching: false)}
  scope :ended, ->{where.not(status: "returning series")}
  scope :on_waitlist, ->{where("waitlist = true")}
  scope :ordered_by_name, ->{order(Arel.sql("regexp_replace(lower(name),'the ','') ASC"))}

  base64_image :poster_image, :backdrop_image

  def self.create_from_imdb_id(imdb_id)
    search_result = Services::Search.tv_shows.search(imdb_id).first
    find_or_create_by(imdb_id: imdb_id) do |tv_show|
      tv_show.name = search_result.title
      tv_show.tvdb_id = search_result.tvdb_id
    end
  end

  def fetch_news
    client = Faraday.new(:url => "https://www.reddit.com") do |builder|
      builder.request  :json
      builder.response :json
      builder.adapter Faraday.default_adapter
    end

    client.get("/search.json?q=subreddit%3Atelevision%20#{name}&sort=top&t=week").body["data"]["children"].each do |item|
      listing = item["data"]
      next if listing["is_self"]
      NewsItem.find_or_create_by(title: listing["title"]) do |news_item|
        news_item.attributes = {url: listing["url"], score: listing["ups"], newsworthy: self, category: "tv_shows" }
      end
    end
  end

  def poster_image(size = 1280)
    return nil unless tmdb_details["poster_path"]
    image = tmdb_details["poster_path"]
    "#{Broad.tmdb_configuration.secure_base_url}w#{size}/#{image}"
  end

  def backdrop_image
    return nil unless tmdb_details.key?("backdrop_path")
    image = tmdb_details["backdrop_path"]
    "#{Broad.tmdb_configuration.secure_base_url}original#{image}"
  end

  def sample
    if tvdb_id.blank?
      self.waitlist = true
      save!
      return self
    end

    sample_result = Services::Btn::Api.new.sample(tvdb_id)

    if sample_result.present?
      sample_result.each do |release|
        episode = Domain::Btn::BuildEpisodeFromEntry.new(self, release).episode
        episode.save
      end
    else
      download_season(1)
    end
    self.waitlist = episodes.with_release.none?
    save!
    self
  end

  def collect
    Broad::ServiceRegistry.trakt_shows.number_of_seasons(imdb_id).times do |season_number|
      download_season(season_number + 1)
    end
    self
  end

  def watch
    self.watching = true
    save!
    self
  end

  def unwatch
    self.watching = false
    save!
    self
  end

  # TODO: There is an uggo hack here to make Dry Struct work.
  def download_season(season_number)
    trakt_episodes = Broad::ServiceRegistry.trakt_shows.episodes(imdb_id).select{|episode| episode.season == season_number}
    season_releases = btn_service.season(tvdb_id, season_number)
    season_releases.each do |release|
      trakt_episodes.each do |episode|
        hash_release = release.to_hash
        hash_release[:episode] = episode.number
        hash_release[:name] = episode.title
        Domain::Btn::BuildEpisodeFromEntry.new(self, OpenStruct.new(hash_release)).episode.save
      end
    end

    download_season_episodes(season_number) if season_releases.count.zero?
    self
  end

  def download_season_episodes(season_number)
    trakt_episodes = Broad::ServiceRegistry.trakt_shows.episodes(imdb_id).select{|episode| episode.season == season_number}

    trakt_episodes.each do |episode|
      releases = btn_service.episode(tvdb_id, season_number, episode.number)
      break if releases.count.zero?
      releases.each do |release|
        Domain::Btn::BuildEpisodeFromEntry.new(self, release).episode.save!
      end
    end
  end

  def btn_service
    @btn_service ||= Services::Btn::Api.new
  end

  private

  def fetch_details
    FetchTvShowDetailsTmdbJob.perform_later self
    FetchTvShowDetailsTraktJob.perform_later self
  end
end
