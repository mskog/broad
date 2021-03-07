module Services
  module Omdb
    # TODO: move constants to ENV
    class Client < SimpleDelegator
      API_URL = "https://www.omdbapi.com".freeze

      def initialize
        super self.class.build_client
      end

      def self.build_client
        headers = {
          "Content-Type" => "application/json"
        }
        Faraday.new(:url => API_URL, params: {apikey: ENV["OMDB_API_KEY"]}) do |builder|
          builder.headers = headers
          builder.request  :json
          builder.response :json
          builder.adapter Faraday.default_adapter
        end
      end
    end
  end
end
