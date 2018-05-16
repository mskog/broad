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
        if result.status == 404
          data = {ids: {}}
        else
          data = result.body
        end
        ::Services::Trakt::Data::ShowExtended.new(data)
      end

    end
  end
end
