module Services
  module Trakt
    class Movies
      def initialize(client = Client.new)
        @client = client
      end

      # TODO Allow default/extended?
      def summary(id)
        ::Services::Trakt::Data::MovieExtended.new @client.get("movies/#{id}", extended: 'full').body
      end

    end
  end
end
