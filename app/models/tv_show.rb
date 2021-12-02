class TvShow < ApplicationRecord
  include Base64Images

  serialize :tmdb_details, Hash
  serialize :trakt_details, Hash

  include PgSearch::Model
  pg_search_scope :kinda_spelled_like,
                  against: :name,
                  using: {
                    tsearch: {prefix: true},
                    trigram: {threshold: 0.3}
                  }

  after_commit :fetch_details, :on => :create

  has_many :seasons
  has_many :episodes, dependent: :destroy
  has_many :news_items, as: :newsworthy, dependent: :destroy

  scope :watching, ->{where("waitlist = false AND (status = 'returning series' OR status IS NULL)").where(watching: true)}
  scope :not_watching, ->{where("waitlist = false AND (status = 'returning series' OR status IS NULL)").where(watching: false)}
  scope :ended, ->{where.not(status: "returning series")}
  scope :on_waitlist, ->{where("waitlist = true")}

  base64_image :poster_image, :backdrop_image

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

  private

  def fetch_details
    FetchTvShowDetailsTmdbJob.perform_later self
    FetchTvShowDetailsTraktJob.perform_later self
  end
end
