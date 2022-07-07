# typed: false

module Services
  module Btn
    class Feed
      include Enumerable

      def initialize(url)
        @url = url
      end

      def published_since(time)
        feed.entries.select do |entry|
          entry.published > time
        end.map{|entry| Services::Btn::Release.from_feed_entry(entry)}
      end

      def each
        feed.entries.each do |entry|
          yield Services::Btn::Release.from_feed_entry(entry) if block_given?
        end
      end

      private

      def feed
        @feed ||= Feedjira.parse(HTTP.get(@url).body.to_s)
      rescue Feedjira::NoParserAvailable
        raise BtnIsProbablyDownError
      end

      class BtnIsProbablyDownError < StandardError; end
    end
  end
end
