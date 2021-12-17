module Services
  module Btn
    class Api
      def initialize(client = Services::Btn::Client.new)
        @client = client
      end

      # Will attempt to fetch the first episode of the show.
      # Btn always(?) has a torrent of this episode ready even with season packs available.
      def sample(tvdb_id)
        Releases
          .new(@client.call("getTorrents", name: "S01E01", tvdb: tvdb_id, category: :episode))
          .select{|release| release.season == 1 && release.episode == 1}
      end

      def season(tvdb_id, season_number)
        search_attributes = {tvdb: tvdb_id, category: :season, name: "Season #{season_number}"}
        Releases.new(@client.call("getTorrents", search_attributes), release_klass: Services::Btn::SeasonRelease)
      end

      def episode(tvdb_id, season_number, episode_number)
        season_episode_name = "S#{season_number.to_s.rjust(2, '0')}E#{episode_number.to_s.rjust(2, '0')}"
        search_attributes = {tvdb: tvdb_id, category: :episode, name: season_episode_name}
        Releases.new(@client.call("getTorrents", search_attributes))
      end

      def get_torrents(search_attributes)
        Releases.new(@client.call("getTorrents", search_attributes))
      end

      class Releases
        include Enumerable

        def initialize(response, release_klass: Services::Btn::Release)
          @entries = response.key?("torrents") ? response["torrents"].values : []
          @release_klass = release_klass
        end

        def each
          @entries.each do |entry|
            yield @release_klass.from_api_entry(entry)
          end
        end
      end
    end
  end
end
