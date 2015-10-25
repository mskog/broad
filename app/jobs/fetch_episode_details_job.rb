class FetchEpisodeDetailsJob < ActiveJob::Base
  queue_as :tmdb

  def perform(episode)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_details(episode)
      refetch_if_necessary(episode)
    end
    sleep 1 unless Rails.env.test?
  end

  private

  def fetch_details(episode)
    data = Tmdb::Episode.detail(episode.tv_show.tmdb_details['id'], episode.season, episode.episode)
    return if data['status_code'].present?
    episode.update tmdb_details: data
  end

  def refetch_if_necessary(episode)
    tmdb_details = episode.tmdb_details
    return if tmdb_details.present? && (tmdb_details['still_path'].present? && tmdb_details['overview'].present?)
    return if episode.created_at < Date.today-1.week
    self.class.set(wait: 1.hour).perform_later episode
  end
end
