module Services
  module Omdb
    class Api
      def initialize(client = Client.new)
        @client = client
      end

      def search(query, type: :movie, **_options)
        if Services::Imdb.matches?(query)
          by_id(query)
        else
          @client.get("/", s: query, type: type).body["Search"]
        end
      end

      def by_id(imdb_id)
        @client.get("/", i: imdb_id).body
      end
    end
  end
end
