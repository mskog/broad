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
    end
  end
end
