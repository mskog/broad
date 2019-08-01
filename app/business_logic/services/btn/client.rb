require "jsonrpc"

module Services
  module BTN
    class Client
      def initialize(api_url: ENV["BTN_API_URL"], api_key: ENV["BTN_API_KEY"])
        @api_url = api_url
        @api_key = api_key
        @client = JsonRpc::Client.connect(@api_url)
      end

      def call(method, *arguments)
        response = @client.call(method, @api_key, *arguments)
        response.is_a?(Hash) ? response : JSON.parse(response)
      end
    end
  end
end
