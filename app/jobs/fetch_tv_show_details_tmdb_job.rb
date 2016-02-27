class FetchTvShowDetailsTmdbJob < ActiveJob::Base
  queue_as :tmdb

  def perform(tv_show)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_details(tv_show)
    end
    sleep 1 unless Rails.env.test?
  end

  private

  def fetch_details(tv_show)
    name = tv_show.name
    matches = name.match /(.*)\(([0-9]+)\)/
    if matches
      shows = tmdb_search.year(matches[2]).query(matches[1].strip).fetch
    else
      shows = tmdb_search.query(name).fetch
    end
    tv_show.update tmdb_details: shows.first
  end

  def tmdb_search
    Tmdb::Search.new.resource("tv")
  end
end
