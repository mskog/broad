# typed: ignore

module Services
  class FetchAndPersistFeedEntries
    extend T::Sig

    sig{params(feed_url: String, published_since: T.any(DateTime, String)).void}
    def initialize(feed_url, published_since)
      @feed_url = feed_url
      @published_since = published_since
    end

    sig{returns(T.untyped)}
    def perform
      feed.published_since(@published_since).reject do |entry|
        entry.dolby_vision && !entry.hdr
      end.each do |entry|
        next if entry.name.blank?
        tv_show = TvShow.watching.find_by(name: entry[:name].strip)
        next if tv_show.blank?
        tv_show.create_episode_from_entry(entry.to_h)
      end
    end

    private

    sig{returns(Services::Btn::Feed)}
    def feed
      @feed ||= Services::Btn::Feed.new(@feed_url)
    end
  end
end
