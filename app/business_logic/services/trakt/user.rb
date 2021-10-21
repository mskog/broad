module Services
  module Trakt
    class User
      def initialize(client = Client.new, token:)
        @client = client
        @token = token
      end

      def ratings_movies
        request("/sync/ratings/movies").body.map do |result|
          Services::Trakt::Data::RatingMovie.new(result)
        end
      end

      def history_shows
        request("/users/me/history/shows").body.map do |result|
          Services::Trakt::Data::HistoryEpisode.new(result)
        end
      end

      def history_movies
        request("/users/me/history/movies").body.map do |result|
          Services::Trakt::Data::HistoryMovie.new(result)
        end
      end

      def collected_show(id)
        Services::Trakt::Data::ProgressShow.new(request("/shows/#{id}/progress/collection").body)
      end

      def watched_show(id)
        Services::Trakt::Data::WatchedShow.new(request("/shows/#{id}/progress/watched").body)
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
