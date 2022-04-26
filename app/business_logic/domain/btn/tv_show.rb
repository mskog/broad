module Domain
  module Btn
    class TvShow < SimpleDelegator
      def self.create_from_imdb_id(imdb_id)
        search_result = Services::Search.tv_shows.search(imdb_id).first
        new(::TvShow.find_or_create_by(imdb_id: imdb_id) do |tv_show|
          tv_show.name = search_result.title
          tv_show.tvdb_id = search_result.tvdb_id
        end)
      end

      def sample
        sample_result = tvdb_id.present? ? Services::Btn::Api.new.sample(tvdb_id) : nil

        if sample_result.present?
          sample_result.each do |release|
            episode = Domain::Btn::BuildEpisodeFromEntry.new(self, release).episode
            episode.save
          end
        else
          download_season(1)
        end
        self.waitlist = episodes.with_release.none?
        save!
        self
      end

      def collect
        Broad::ServiceRegistry.trakt_shows.number_of_seasons(imdb_id).times do |season_number|
          download_season(season_number + 1)
        end
        self
      end

      # TODO: There is an uggo hack here to make Dry Struct work.
      def download_season(season_number)
        trakt_episodes = Broad::ServiceRegistry.trakt_shows.episodes(imdb_id).select{|episode| episode.season == season_number}
        season_releases = btn_service.season(tvdb_id, season_number)
        season_releases.each do |release|
          trakt_episodes.each do |episode|
            hash_release = release.to_hash
            hash_release[:episode] = episode.number
            hash_release[:name] = episode.title
            Domain::Btn::BuildEpisodeFromEntry.new(self, OpenStruct.new(hash_release)).episode.save
          end
        end

        download_season_episodes(season_number) if season_releases.count.zero?
        self
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
        trakt_episodes = Broad::ServiceRegistry.trakt_shows.episodes(imdb_id).select{|episode| episode.season == season_number}

        trakt_episodes.each do |episode|
          releases = btn_service.episode(tvdb_id, season_number, episode.number)
          break if releases.count.zero?
          releases.each do |release|
            Domain::Btn::BuildEpisodeFromEntry.new(self, release).episode.save!
          end
        end
      end

      def aired_season_episodes(season_number)
        episodes
          .aired
          .unwatched
          .without_release
          .where(season_number: season_number)
          .order(episode: :asc)
      end

      def btn_service
        @btn_service ||= Services::Btn::Api.new
      end
    end
  end
end
