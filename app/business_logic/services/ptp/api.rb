module Services
  module PTP
    class Api
      def initialize(client = Client.new)
        @client = client
      end

      def search(query)
        response = @client.get("torrents.php?searchstr=#{query}&json=noredirect")

        # Uncomment to save to fixture.
        # save_fixture(query.parameterize.underscore, response)

        SearchResult.new(response)
      end

      private

      def save_fixture(name, response)
        result = response.body
        result["AuthKey"] = "key"
        result["PassKey"] = "key"

        File.open("spec/fixtures/ptp/#{name}.json", "w") do |file|
          file << result.to_json
        end
      end

      class SearchResult
        def initialize(response)
          @response = response
        end

        def present?
          !@response.body["Movies"].empty?
        end

        def movie
          Services::PTP::Movie.new(first_movie, auth_key)
        end

        private

        def first_movie
          @response.body["Movies"][0]
        end

        def auth_key
          @response.body["AuthKey"]
        end
      end
    end
  end
end
