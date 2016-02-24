module Services
  module Trakt
    class Search
      def initialize(client = Client.new)
        @client = client
      end

      def movies(query, **options)
        @client.get('search', query: query, type: :movie, **options).body
      end

      def shows(query, **options)
        @client.get('search', query: query, type: :show, **options).body
      end

      def id(id, id_type: :imdb)
        @client.get('search', id_type: id_type, id: id).body
      end
    end
  end
end
