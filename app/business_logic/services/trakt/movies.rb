module Services
  module Trakt
    class Movies
      def initialize(client = Client.new)
        @client = client
      end

      # TODO Allow default/extended?
      def summary(id)
        result = @client.get("movies/#{id}", extended: 'full')
        if result.status == 404
          data = {ids: {}}
        else
          data = result.body
        end
        ::Services::Trakt::Data::MovieExtended.new(data)
      end

    end
  end
end
