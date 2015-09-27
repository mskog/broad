module Services
  module PTP
    class Client < SimpleDelegator
      API_URL = "https://tls.passthepopcorn.me"
      LOGIN_URL = "ajax.php?action=login"

      def initialize
        @connection = Faraday.new(:url => API_URL) do |builder|
          builder.use :cookie_jar
          builder.request  :url_encoded
          builder.response :json
          builder.adapter Faraday.default_adapter
        end
        login
        super @connection
      end

      private

      def login
        # TODO Check for non-200?
        @connection.post(LOGIN_URL, {username: ENV['PTP_USERNAME'], password: ENV['PTP_PASSWORD'], passkey: ENV['PTP_PASSKEY']})
      end
    end
  end
end
