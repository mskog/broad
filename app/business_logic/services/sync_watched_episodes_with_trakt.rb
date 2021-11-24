module Services
  class SyncWatchedEpisodesWithTrakt
    def initialize
      @api = Broad::ServiceRegistry.trakt_user
    end

    def perform
      trakt_episodes.each do |trakt_episode|
        episode = Episode.joins(:tv_show).where(watched: false, tv_shows: {imdb_id: trakt_episode.show.ids.imdb}, season_number: trakt_episode.episode.season, episode: trakt_episode.episode.number)
        next unless episode.present?
        episode.update watched: true, watched_at: DateTime.current
      end
    end

    private

    def trakt_episodes
      @api.history_shows
    end
  end
end
