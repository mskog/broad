class FetchEpisodeDetailsJob < ActiveJob::Base
  queue_as :tmdb

  def perform(episode)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_details(episode)
      refetch_if_necessary(episode)
    end
    sleep rand(10) unless Rails.env.test?
  end

  private

  def fetch_details(episode)
    data = Tmdb::Episode.detail(episode.tv_show.tmdb_details["id"], episode.season_number, episode.episode)
    return if data["status_code"].present?
    episode.update tmdb_details: data, air_date: data["air_date"]
  end

  def refetch_if_necessary(episode)
    tmdb_details = episode.tmdb_details
    return if tmdb_details.present? && (tmdb_details["still_path"].present? && tmdb_details["overview"].present?)
    return if episode.created_at < Date.today - 1.week
    self.class.set(wait: 3.hours).perform_later episode
  end
end
