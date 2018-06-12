class FetchTvShowDetailsTraktJob < ActiveJob::Base
  queue_as :tmdb

  def perform(tv_show)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_details(tv_show)
      sleep 1 unless Rails.env.test?
      fetch_episodes_information(tv_show) if tv_show['trakt_details'].present?
    end
    sleep 1 unless Rails.env.test?
  end

  private

  def fetch_details(tv_show)
    details = ::Broad::ServiceRegistry.trakt_search.shows(tv_show.name).first
    return unless details.present? && details.ids.imdb.present?
    tv_show.update trakt_details: VirtusConvert.new(details).to_hash, imdb_id: details.ids.imdb, tvdb_id: details.ids.tvdb
  end

  def fetch_episodes_information(tv_show)
    ::Broad::ServiceRegistry.trakt_shows.episodes(tv_show.imdb_id).each do |trakt_episode|
      tv_show.episodes.find_or_create_by(season: trakt_episode.season, episode: trakt_episode.number) do |episode|
        episode.name = trakt_episode.title
      end
    end
  end
end
