module Services
  module BTN
    class Api
      def initialize(client = Services::BTN::Client.new)
        @client = client
      end

      # Will attempt to fetch the first episode of the show.
      # BTN always(?) has a torrent of this episode ready even with season packs available.
      def sample(tvdb_id)
        Releases.new(@client.call('getTorrents', {tvdb: tvdb_id, category: :episode}))
          .select{|release| release.season == 1 && release.episode == 1}
      end

      def get_torrents(search_attributes)
        Releases.new(@client.call('getTorrents', search_attributes))
      end

      class Releases
        include Enumerable

        def initialize(response)
          @entries = response.key?('torrents') ? response['torrents'].values : []
        end

        def each
          @entries.each do |entry|
            yield Services::BTN::Release.from_api_entry(entry)
          end
        end
      end
    end
  end
end
