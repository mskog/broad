module Services
  module Trakt
    class Sync
      def initialize(client = Client.new, token: ::Credential.find_by(name: :trakt).data["access_token"])
        @client = client
        @token = token
      end

      def rate_movie(imdb_id, rating)
        request("/sync/ratings", movies: [{rating: rating, ids: {imdb: imdb_id}}])
      end

      private

      def request(route, method: :post, **params)
        @client.public_send(method, route, **params) do |request|
          request.headers["authorization"] = "Bearer #{@token}"
        end
      end
    end
  end
end
