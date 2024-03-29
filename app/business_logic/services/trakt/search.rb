module Services
  module Trakt
    class Search
      def initialize(client = Client.new)
        @client = client
      end

      def movies(query, **options)
        @client.get("search", query: query, type: :movie, field: "title", limit: 25, **options).body.map do |result|
          Services::Trakt::Data::MovieWithDetails.new(result["movie"])
        end
      end

      def shows(query, **options)
        @client.get("search", query: query, type: :show, limit: 25, **options).body.map do |result|
          Services::Trakt::Data::ShowWithDetails.new(result["show"])
        end
      end

      def id(id, id_type: :imdb, type: :movie)
        @client.get("search/#{id_type}/#{id}", type: type, extended: "full").body.map do |result|
          if type.to_sym == :movie
            Services::Trakt::Data::MovieWithDetails.new(result["movie"])
          else
            Services::Trakt::Data::ShowWithDetails.new(result["show"])
          end
        end
      end
    end
  end
end
