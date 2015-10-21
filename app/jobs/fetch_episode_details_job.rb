class FetchEpisodeDetailsJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_details(episode)
    end
    sleep 1 unless Rails.env.test?
  end

  private

  def fetch_details(episode)
    data = Tmdb::Episode.detail(episode.tv_show.tmdb_details['id'], episode.season, episode.episode)
    return if data['status_code'].present?
    episode.update tmdb_details: data
  end
end
