module ViewObjects
  class TvShowsCalendar
    def initialize(from_date: Date.yesterday, days: 7, cache_key_prefix: nil)
      @from_date = from_date
      @days = days
      @cache_key_prefix = cache_key_prefix
    end

    def by_date
      @by_date ||= episodes.group_by{|episode| episode.first_aired.to_date}
    end

    def episodes
      @episodes ||= trakt_calendar.shows(**{from_date: @from_date, days: @days}.compact) + trakt_calendar.show_premieres(**{from_date: @from_date+@days.days, days: 90}.compact)
    end

    def watching
      shows = ::TvShow.all
      @episodes = episodes.each_with_object([]) do |episode, object|
        show = shows.find{|sh| sh.imdb_id == episode.show.ids.imdb}
        next unless show.present?
        object << WatchingShow.new(show, episode)
      end
      self
    end

    def cache_key
      ['viewobjects', 'tv_shows_calendar', @cache_key_prefix, @from_date.try(:to_time).try(:to_i), @days].compact.join('-')
    end

    private

    def trakt_calendar
      ::Broad::ServiceRegistry.trakt_calendar
    end

    class WatchingShow < SimpleDelegator
      delegate :ids, :number, :season, :title, to: "@calendar_episode.episode"
      delegate :first_aired, to: "@calendar_episode"

      def initialize(tv_show, calendar_episode)
        @calendar_episode = calendar_episode
        super tv_show
      end

      def poster
        trakt_details[:images][:poster][:thumb]
      end
    end
  end
end
