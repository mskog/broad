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
    details = Services::Trakt::Search.new.shows(tv_show.name).first
    tv_show.update trakt_details: VirtusConvert.new(details).to_hash
  end
end
