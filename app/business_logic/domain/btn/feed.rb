module Domain
  module BTN
    class Feed
      include Enumerable

      def initialize(url)
        @feed = Feedjira::Feed.fetch_and_parse url
      end

      def published_since(time)
        @feed.entries.select do |entry|
          entry.published > time
        end.map{|entry| Domain::BTN::Release.from_feed_entry(entry)}
      end

      def each(&block)
        @feed.entries.each do |entry|
          yield Domain::BTN::Release.from_feed_entry(entry)
        end
      end
    end
  end
end
