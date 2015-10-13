module Services
  module PTP
    class Client < SimpleDelegator
      API_URL = "https://tls.passthepopcorn.me"
      LOGIN_URL = "ajax.php?action=login"

      def initialize
        @connection = self.class.build_client
        @logged_in = false
        super @connection
      end

      def post(*)
        login
        super
      end

      def get(*)
        login
        super
      end

      private

      def self.build_client
        Faraday.new(:url => API_URL) do |builder|
          builder.use :cookie_jar
          builder.request  :url_encoded
          builder.response :json
          builder.adapter Faraday.default_adapter
        end
      end

      def login
        return if @logged_in
        # TODO Check for non-200?
        @connection.post(LOGIN_URL, {username: ENV['PTP_USERNAME'], password: ENV['PTP_PASSWORD'], passkey: ENV['PTP_PASSKEY']})
        @logged_in = true
      end
    end
  end
end
