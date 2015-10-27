module Services
  class FetchAndPersistFeedEntries
    def initialize(feed_url, published_since)
      @feed_url = feed_url
      @published_since = published_since
    end

    def perform
      feed.published_since(@published_since).each do |entry|
        next unless entry.name.present?
        show = TvShow.find_or_create_by(name: entry[:name])
        episode = Domain::BTN::BuildEpisodeFromEntry.new(show, entry).episode
        episode.save
      end
    end

    private

    def feed
      @feed ||= Services::BTN::Feed.new(@feed_url)
    end
  end
end
