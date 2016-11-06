module Services
  module Trakt
    class User
      def initialize(client = Client.new, token:)
        @client = client
        @token = token
      end

      def history_shows
        request("/users/me/history/shows").body.map do |result|
          Services::Trakt::Data::HistoryEpisode.new(result)
        end
      end

      private

      def request(route, method: :get)
        @client.public_send(method, route) do |request|
          request.headers['authorization'] = "Bearer #{@token}"
        end
      end
    end
  end
end
