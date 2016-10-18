module Services
  module Trakt
    class Recommendations
      def initialize(client = Client.new, token:)
        @client = client
        @token = token
      end

      def movies
        request("recommendations/movies").body.map do |result|
          Services::Trakt::Data::Movie.new(result)
        end
      end

      private

      def request(route)
        @client.get(route) do |request|
          request.headers['authorization'] = "Bearer #{@token}"
        end
      end
    end
  end
end
