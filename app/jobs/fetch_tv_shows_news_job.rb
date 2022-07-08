# typed: false
class FetchTvShowsNewsJob < ActiveJob::Base
  queue_as :reddit

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      client = Faraday.new(:url => "https://www.reddit.com") do |builder|
        builder.request :json
        builder.response :json
        builder.adapter Faraday.default_adapter
      end

      client.get("/r/television/top.json").body["data"]["children"].each do |item|
        listing = item["data"]
        next if listing["is_self"]
        NewsItem.find_or_create_by(title: listing["title"]) do |news_item|
          news_item.attributes = {url: listing["url"], score: listing["ups"], category: "tv_shows" }
        end
      end

      TvShow.watching.or(TvShow.on_waitlist).find_each do |tv_show|
        tv_show.fetch_news
        sleep rand(10) unless Rails.env.test?
      end
    end
  end
end
