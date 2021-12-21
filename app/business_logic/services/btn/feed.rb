module Services
  module BTN
    class Feed
      include Enumerable

      def initialize(url)
        @url = url
      end

      def published_since(time)
        feed.entries.select do |entry|
          entry.published > time
        end.map{|entry| Services::BTN::Release.from_feed_entry(entry)}
      end

      def each
        feed.entries.each do |entry|
          yield Services::BTN::Release.from_feed_entry(entry)
        end
      end

      private

      def feed
        @feed ||= Feedjira::Feed.fetch_and_parse @url
      rescue Feedjira::NoParserAvailable, Feedjira::FetchFailure
        raise BTNIsProbablyDownError
      end

      class BTNIsProbablyDownError < StandardError; end
    end
  end
end
