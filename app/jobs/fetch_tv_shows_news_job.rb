class FetchTvShowsNewsJob < ActiveJob::Base
  queue_as :reddit

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      TvShow.find_each do |tv_show|
        tv_show.fetch_news
        sleep rand(30) unless Rails.env.test?
      end
    end
  end
end
