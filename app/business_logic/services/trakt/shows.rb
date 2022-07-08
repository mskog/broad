# typed: true
module Services
  module Trakt
    class Shows
      def initialize(client = Client.new)
        @client = client
      end

      # TODO: Allow default/extended?
      # TODO Air times?
      def summary(id)
        result = @client.get("shows/#{id}", extended: "full")
        data = if result.status == 404
                 return nil
               else
                 result.body
               end
        ::Services::Trakt::Data::ShowExtended.new(data)
      end

      def number_of_seasons(id)
        episodes(id).map(&:season).max
      end

      # Will use the seasons api endpoint to fetch just the episodes information
      # TODO: Missing some specs for special cases. Test setup can be annoying. Ideas?
      def episodes(id)
        body =
          @client
          .get("shows/#{id}/seasons?extended=episodes")
          .body

        return [] if body.blank?
        body
          .select{|season| season.key?("episodes")}
          .flat_map{|season| season.fetch("episodes")}
          .reject{|episode| episode["season"].zero?}
          .map{|episode| ::Services::Trakt::Data::Episode.new(episode)}
      end
    end
  end
end
