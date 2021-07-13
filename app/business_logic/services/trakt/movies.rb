module Services
  module Trakt
    class Movies
      def initialize(client = Client.new)
        @client = client
      end

      # TODO: Allow default/extended?
      def summary(id)
        result = @client.get("movies/#{id}", extended: "full")
        data = if result.status == 404
                 {ids: {}}
               else
                 result.body
               end
        ::Services::Trakt::Data::MovieExtended.new(data)
      end

      def release_date(id, release_type = nil)
        response = @client.get("movies/#{id}/releases/us")
        return nil if response.status == 404

        result = response.body
        result = result.select{|item| item["release_type"] == release_type} if release_type.present?

        date = result.min do |a, b|
          a["release_date"] <=> b["release_date"]
        end.fetch("release_date")

        Date.parse date
      end
    end
  end
end
