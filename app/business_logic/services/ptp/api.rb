module Services
  module PTP
    class Api
      def initialize(client = Client.new)
        @client = client
      end

      def search_by_imdb_url(url)
        Domain::PTP::Movie.new(@client.get("torrents.php?searchstr=#{url}&json=noredirect").body['Movies'][0])
      end
    end
  end
end
