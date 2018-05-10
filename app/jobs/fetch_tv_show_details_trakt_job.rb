class FetchTvShowDetailsTraktJob < ActiveJob::Base
  queue_as :tmdb

  def perform(tv_show)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_details(tv_show)
    end
    sleep 1 unless Rails.env.test?
  end

  private

  def fetch_details(tv_show)
    details = ::Broad::ServiceRegistry.trakt_search.shows(tv_show.name).first
    return unless details.present? && details.ids.imdb.present?
    tv_show.update trakt_details: VirtusConvert.new(details).to_hash, imdb_id: details.ids.imdb
  end
end
