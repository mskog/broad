class FetchTvShowDetailsJob < ActiveJob::Base
  queue_as :tmdb

  def perform(tv_show)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_details(tv_show)
    end
    sleep 1 unless Rails.env.test?
  end

  private

  def fetch_details(tv_show)
    matches = tv_show.name.match /(.*)\(([0-9]+)\)/
    if matches
      shows = Tmdb::Search.new.resource("tv").year(matches[2]).query(matches[1].strip).fetch
    else
      shows = Tmdb::Search.new.resource("tv").query(tv_show.name).fetch
    end
    show = shows.first
    tv_show.update tmdb_details: show
  end
end
