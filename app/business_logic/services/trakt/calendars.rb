module Services
  module Trakt
    class Calendars
      def initialize(client = Client.new, token:)
        @client = client
        @token = token
      end

      def shows(from_date: Date.today, days: 7)
        request("calendars/my/shows/#{from_date}/#{days}").body.map do |result|
          Result.new(result)
        end
      end

      private

      def request(route)
        @client.get(route) do |request|
          request.headers['authorization'] = "Bearer #{@token}"
        end
      end

      class Result
        include Virtus.model

        attribute :episode, Services::Trakt::Data::Episode
        attribute :show, Services::Trakt::Data::Show
        attribute :first_aired, DateTime
      end
    end
  end
end
