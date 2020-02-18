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
                 {ids: {}}
               else
                 result.body
               end
        ::Services::Trakt::Data::ShowExtended.new(data)
      end

      # Will use the seasons api endpoint to fetch just the episodes information
      def episodes(id)
        @client
          .get("shows/#{id}/seasons?extended=episodes")
          .body
          .select{|season| season.key?("episodes")}
          .flat_map{|season| season.fetch("episodes")}
          .reject{|episode| episode["season"].zero?}
          .map{|episode| ::Services::Trakt::Data::Episode.new(episode)}
      end
    end
  end
end
