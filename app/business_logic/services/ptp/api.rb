# typed: false

module Services
  module Ptp
    class Api
      def initialize(client = Client.new)
        @client = client
      end

      def search(query)
        response = @client.get("torrents.php?searchstr=#{query}&json=noredirect") do |request|
          request.headers["Content-Type"] = "application/json"
        end

        # Uncomment to save to fixture.
        # save_fixture(query.parameterize.underscore, response)

        SearchResult.new(response)
      end

      # No specs because it is dangerous to write fixtures for it
      # TODO We can get the other top lists by the index in the coverViewJsonData object
      def top
        response = @client.get("top10.php") do |request|
          request.headers["Content-Type"] = "text/html"
        end

        JSON.parse(response.body.match(/coverViewJsonData\[ 1 \] = ({.*})/)[1])["Movies"].map do |result|
          TopMovie.new(result)
        end
      end

      private

      def save_fixture(name, response)
        result = response.body
        result["AuthKey"] = "key"
        result["PassKey"] = "key"

        File.open("spec/fixtures/Ptp/#{name}.json", "w") do |file|
          file << result.to_json
        end
      end

      class SearchResult
        def initialize(response)
          @response = JSON.parse(response.body)
        end

        def present?
          !@response["Movies"].empty?
        end

        def movie
          return nil if first_movie.blank?
          data = first_movie
          data[:auth_key] = auth_key
          data[:releases] = data["Torrents"]
          Services::Ptp::Movie.new(data)
        end

        private

        def first_movie
          @response["Movies"][0]
        end

        def auth_key
          @response["AuthKey"]
        end
      end
    end
  end
end
