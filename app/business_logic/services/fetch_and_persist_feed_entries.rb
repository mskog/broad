module Services
  class FetchAndPersistFeedEntries
    def initialize(feed_url, published_since)
      @feed_url = feed_url
      @published_since = published_since
    end

    def perform
      feed.published_since(@published_since).each do |entry|
        next unless entry.name.present?
        episode = self.class.build_episode(entry)
        episode.releases.find_or_create_by(entry.to_h.except(:name, :episode, :year, :season))
      end
    end

    private

    def self.build_episode(entry)
      show = TvShow.find_or_create_by(name: entry[:name])
      @episode = show.episodes.find_or_create_by(entry.to_h.slice(:name, :episode, :year, :season)) do |episode|
        episode.published_at = entry.published_at
      end
    end

    def feed
      @feed ||= Services::BTN::Feed.new(@feed_url)
    end
  end
end
