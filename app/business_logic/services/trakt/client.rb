module Services
  module Trakt

    # TODO move constants to ENV
    class Client < SimpleDelegator
      API_URL = "https://api-v2launch.trakt.tv"
      API_VERSION = "2"

      def initialize
        super self.class.build_client
      end

      private

      def self.build_client
        headers = {
          'Content-Type' => 'application/json',
          'trakt-api-key' => ENV['TRAKT_APIKEY'],
          "trakt-api-version" => API_VERSION
        }
        Faraday.new(:url => API_URL) do |builder|
          builder.headers = headers
          builder.request  :json
          builder.response :json
          builder.adapter Faraday.default_adapter
        end
      end
    end
  end
end
