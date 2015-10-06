module Services
  module PTP
    class Api
      def initialize(client = Client.new)
        @client = client
      end

      def search_by_imdb_url(url)
        response = @client.get("torrents.php?searchstr=#{url}&json=noredirect")
        SearchResult.new(response)
      end

      class SearchResult
        def initialize(response)
          @response = response
        end

        def present?
          !@response.body['Movies'].empty?
        end

        def movie
          Services::PTP::Movie.new(first_movie, auth_key)
        end

        private

        def first_movie
          @response.body['Movies'][0]
        end

        def auth_key
          @response.body['AuthKey']
        end
      end
    end
  end
end
