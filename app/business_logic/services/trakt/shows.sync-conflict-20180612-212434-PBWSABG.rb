module Services
  module Trakt
    class Shows
      def initialize(client = Client.new)
        @client = client
      end

      # TODO Allow default/extended?
      # TODO Air times?
      def summary(id)
        result = @client.get("shows/#{id}", extended: 'full')
        data = if result.status == 404
                 {ids: {}}
               else
                 result.body
               end
        ::Services::Trakt::Data::ShowExtended.new(data)
      end

      # Will use the seasons api endpoint to fetch just the episodes information
      def episodes(id, include_extras: false)
        @client
          .get("shows/#{id}/seasons?extended=episodes")
          .body
          .flat_map{|season| season.fetch('episodes')}
      end
    end
  end
end
