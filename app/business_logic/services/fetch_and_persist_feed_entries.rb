module Services
  class FetchAndPersistFeedEntries
    def initialize(feed_url, published_since)
      @feed_url = feed_url
      @published_since = published_since
    end

    def perform
      feed.published_since(@published_since).reject(&:dolby_vision).each do |entry|
        next if entry.name.blank?
        tv_show = TvShow.watching.find_by(name: entry[:name].strip)
        next if tv_show.blank?
        episode = Episode.build_from_entry(tv_show, entry)
        episode.save
      end
    end

    private

    def feed
      @feed ||= Services::Btn::Feed.new(@feed_url)
    end
  end
end
