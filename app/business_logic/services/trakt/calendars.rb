module Services
  module Trakt
    class Calendars
      def initialize(client = Client.new, token:)
        @client = client
        @token = token
      end

      def shows(from_date: Date.today, days: 7)
        request("calendars/my/shows/#{from_date}/#{days}").body
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
