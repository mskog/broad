# typed: false
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
                 return nil
               else
                 result.body
               end
        ::Services::Trakt::Data::MovieExtended.new(data)
      end

      def release_date(id, release_type = nil)
        response = @client.get("movies/#{id}/releases/us")
        return nil if response.status == 404

        result = response.body
        return nil if result.empty?

        result = result.select{|item| item["release_type"] == release_type} if release_type.present?

        date = Hash(result.min do |a, b|
          a["release_date"] <=> b["release_date"]
        end).fetch("release_date", nil)

        date.present? ? Date.parse(date) : nil
      end
    end
  end
end
