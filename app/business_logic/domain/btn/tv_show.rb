module Domain
  module BTN
    class TvShow < SimpleDelegator
      def self.create_from_imdb_id(imdb_id)
        search_result = Services::Search.tv_shows.search(imdb_id).first
        new(::TvShow.find_or_create_by(imdb_id: imdb_id) do |tv_show|
          tv_show.name = search_result.title
          tv_show.tvdb_id = search_result.tvdb_id
        end)
      end

      def sample
        Services::BTN::Api.new.sample(tvdb_id).each do |release|
          episode = Domain::BTN::BuildEpisodeFromEntry.new(self, release).episode
          episode.save
        end
      end

      def download_season(season_number)
        season_releases = btn_service.season(tvdb_id, season_number)
        season_releases.each do |release|
          episodes.where(season: season_number).each do |episode|
            Domain::BTN::BuildEpisodeFromEntry.new(self, release, episode: episode).episode.save
          end
        end

        download_season_episodes(season_number) if season_releases.count.zero?
      end

      def watch
        self.watching = true
        save!
        self
      end

      def unwatch
        self.watching = false
        save!
        self
      end

      private

      def download_season_episodes(season_number)
        episodes.where(season: season_number).each do |episode|
          releases = btn_service.episode(tvdb_id, season_number, episode.episode)
          break 2 if releases.count.zero?
          releases.each do |release|
            Domain::BTN::BuildEpisodeFromEntry.new(self, release, episode: episode).episode.save
          end
        end
      end

      def btn_service
        @btn_service ||= Services::BTN::Api.new
      end
    end
  end
end
