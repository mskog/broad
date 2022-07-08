# typed: true
class FetchMovieNewsJob < ActiveJob::Base
  queue_as :reddit

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      client = Faraday.new(:url => "https://www.reddit.com") do |builder|
        builder.request :json
        builder.response :json
        builder.adapter Faraday.default_adapter
      end

      client.get("/r/movies/top.json").body["data"]["children"].each do |item|
        listing = item["data"]
        next if listing["is_self"]
        NewsItem.find_or_create_by(title: listing["title"]) do |news_item|
          news_item.attributes = {url: listing["url"], score: listing["ups"], category: "movies" }
        end
      end
    end
  end
end
