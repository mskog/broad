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
    end
  end
end
