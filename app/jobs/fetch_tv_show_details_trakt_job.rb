class FetchTvShowDetailsTraktJob < ApplicationJob
  queue_as :tmdb

  def perform(tv_show)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_details(tv_show)
      sleep 1 unless Rails.env.test?
      fetch_episodes_information(tv_show) if tv_show["trakt_details"].present?
      sleep 1 unless Rails.env.test?
    end
  end

  private

  def fetch_details(tv_show)
    raise StandardError, "No IMDB ID" if tv_show.imdb_id.blank?
    details = ::Broad::ServiceRegistry.trakt_shows.summary(tv_show.imdb_id)
    return unless details.present? && details.ids.imdb.present?
    return if TvShow.where.not(id: tv_show.id).find_by(imdb_id: details.ids.imdb).present?

    summary_details = ::Broad::ServiceRegistry.trakt_shows.summary(details.ids.imdb)
    tv_show.update status: details.status, trakt_details: summary_details.to_hash, imdb_id: details.ids.imdb, tvdb_id: details.ids.tvdb
  end

  def fetch_episodes_information(tv_show)
    ::Broad::ServiceRegistry.trakt_shows.episodes(tv_show.imdb_id).each do |trakt_episode|
      tv_show.episodes.find_or_create_by(season_number: trakt_episode.season, episode: trakt_episode.number) do |episode|
        episode.name = trakt_episode.title
      end
    end
  end
end
