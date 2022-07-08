# typed: true
module Services
  module Trakt
    class Token
      def initialize(client = Client.new)
        @client = client
      end

      def exchange(auth_code)
        attributes = {
          code: auth_code,
          grant_type: "authorization_code",
          client_id: ENV["TRAKT_APIKEY"],
          client_secret: ENV["TRAKT_APISECRET"],
          redirect_uri: ENV["TRAKT_REDIRECT_URI"]
        }
        @client.post("/oauth/token", attributes).body
      end

      def refresh(refresh_token)
        attributes = {
          client_id: ENV["TRAKT_APIKEY"],
          client_secret: ENV["TRAKT_APISECRET"],
          redirect_uri: ENV["TRAKT_REDIRECT_URI"],
          refresh_token: refresh_token,
          grant_type: "refresh_token"
        }
        @client.post("/oauth/token", attributes).body
      end
    end
  end
end
