module Services
  module PTP
    # TODO: Specs for cookie handling
    class Client < SimpleDelegator
      API_URL = "https://passthepopcorn.me".freeze
      LOGIN_URL = "ajax.php?action=login".freeze
      COOKIE_CACHE_KEY = "ptp_cookie".freeze

      def self.build_client(cookie_jar)
        Faraday.new(:url => API_URL) do |builder|
          builder.use :cookie_jar, jar: cookie_jar
          builder.request  :url_encoded
          builder.response :json
          builder.adapter Faraday.default_adapter
        end
      end

      def initialize
        @cookie_jar = HTTP::CookieJar.new
        @cookie_jar.load(cookie_data)
        @connection = self.class.build_client(@cookie_jar)
        @logged_in = !@cookie_jar.empty?
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

      def cookie_data
        @cookie_data ||= StringIO.new(Rails.cache.fetch(COOKIE_CACHE_KEY).to_s)
      end

      def login
        return if @logged_in
        # TODO: Check for non-200?
        options = {
          username: ENV["PTP_USERNAME"],
          password: ENV["PTP_PASSWORD"],
          passkey: ENV["PTP_PASSKEY"],
          keeplogged: "true"
        }
        @connection.post(LOGIN_URL, options)
        @logged_in = true
        persist_cookie
      end

      def persist_cookie
        @cookie_jar.save(cookie_data, session: true)
        cookie_data.rewind
        Rails.cache.write(COOKIE_CACHE_KEY, cookie_data.read, expires_in: 1.day)
      end
    end
  end
end
