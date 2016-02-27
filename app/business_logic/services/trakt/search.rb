module Services
  module Trakt
    class Search
      def initialize(client = Client.new)
        @client = client
      end

      def movies(query, **options)
        @client.get('search', query: query, type: :movie, **options).body.map do |result|
          Services::Trakt::Data::MovieWithDetails.new(result['movie'])
        end
      end

      def shows(query, **options)
        @client.get('search', query: query, type: :show, **options).body.map do |result|
          Services::Trakt::Data::ShowWithDetails.new(result['show'])
        end
      end

      def id(id, id_type: :imdb)
        @client.get('search', id_type: id_type, id: id).body.map do |result|
          if result['type'] == 'movie'
            Services::Trakt::Data::MovieWithDetails.new(result['movie'])
          elsif result['type'] == 'show'
            Services::Trakt::Data::ShowWithDetails.new(result['show'])
          end
        end
      end
    end
  end
end
