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

      class Ids
        include Virtus.model

        attribute :imdb
        attribute :tmdb
        attribute :trakt
        attribute :tvdb
        attribute :tvrage
        attribute :slug
      end

      class Episode
        include Virtus.model

        attribute :ids, Ids

        attribute :number, Integer
        attribute :season, Integer
        attribute :title, String
      end

      class Show
        include Virtus.model

        attribute :ids, Ids

        attribute :title, String
        attribute :year, Integer
      end

      class Result
        include Virtus.model

        attribute :episode, Episode
        attribute :show, Show
        attribute :first_aired, DateTime
      end
    end
  end
end
