module Services
  module Trakt
    class Recommendations
      DEFAULT_MOVIE_LIMIT = 10

      def initialize(client = Client.new, token:)
        @client = client
        @token = token
      end

      def movies(limit: DEFAULT_MOVIE_LIMIT)
        request("recommendations/movies?limit=#{limit}").body.map do |result|
          Services::Trakt::Data::Movie.new(result)
        end
      end

      def hide_movie(trakt_id)
        request("recommendations/movies/#{trakt_id}", method: :delete)
      end

      private

      def request(route, method: :get)
        @client.public_send(method, route) do |request|
          request.headers["authorization"] = "Bearer #{@token}"
        end
      end
    end
  end
end
