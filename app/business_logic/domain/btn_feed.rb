module Domain
  class BTNFeed
    include Enumerable

    def initialize(url)
      @feed = Feedjira::Feed.fetch_and_parse url
    end

    def published_since(time)
      @feed.entries.select do |entry|
        entry.published > time
      end.map{|entry| Domain::Release.new(entry)}
    end

    def each(&block)
      @feed.entries.each do |entry|
        yield Domain::Release.new(entry)
      end
    end
  end
end
