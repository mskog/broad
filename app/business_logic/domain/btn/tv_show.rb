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
        sample_result = Services::Btn::Api.new.sample(tvdb_id)

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

      def btn_service
        @btn_service ||= Services::Btn::Api.new
      end
    end
  end
end
