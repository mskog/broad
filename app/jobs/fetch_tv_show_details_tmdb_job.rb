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
    raise StandardError, "No IMDB ID" unless tv_show.imdb_id.present?
    details = Tmdb::Find.imdb_id(tv_show.imdb_id)["tv_results"].first
    tv_show.update tmdb_details: details
  end

  def tmdb_search
    Tmdb::Search.new.resource("tv")
  end
end
