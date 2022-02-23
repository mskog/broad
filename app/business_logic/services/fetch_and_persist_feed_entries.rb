module Services
  class FetchAndPersistFeedEntries
    def initialize(feed_url, published_since)
      @feed_url = feed_url
      @published_since = published_since
    end

    def perform
      feed.published_since(@published_since).each do |entry|
        next unless entry.name.present?
        tv_show = TvShow.watching.find_by_name(entry[:name].strip)
        next unless tv_show.present?
        episode = Domain::Btn::BuildEpisodeFromEntry.new(tv_show, entry).episode
        episode.save
      end
    end

    private

    def feed
      @feed ||= Services::Btn::Feed.new(@feed_url)
    end
  end
end
