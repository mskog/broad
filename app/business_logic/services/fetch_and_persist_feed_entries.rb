module Services
  class FetchAndPersistFeedEntries
    def initialize(feed_url, published_since)
      @feed_url = feed_url
      @published_since = published_since
    end

    def perform
      feed.published_since(@published_since).each do |entry|
        episode = Episode.find_or_create_by(name: entry.name, season: entry.season, episode: entry.episode, year: entry.year) do |episode|
          episode.published_at = entry.published_at
        end
        release_attributes = {
          title: entry.title,
          url: entry.url,
          file_type: entry.file_type,
          file_encoding: entry.file_encoding,
          source: entry.source,
          resolution: entry.resolution,
          published_at: entry.published_at
        }
        episode.releases.find_or_create_by(release_attributes)
      end
    end

    private

    def feed
      @feed ||= Domain::BTNFeed.new(@feed_url)
    end
  end
end
