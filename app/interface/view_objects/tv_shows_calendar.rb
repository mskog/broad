module ViewObjects
  class TvShowsCalendar < SimpleDelegator
    def initialize(from_date: nil, days: nil, cache_key_prefix: nil)
      @from_date = from_date.presence || Date.yesterday
      @days = days
      @cache_key_prefix = cache_key_prefix
    end

    def by_date
      @by_date ||= episodes.group_by{|episode| episode.first_aired.to_date}
    end

    def episodes
      @episodes ||= trakt_calendar.shows(**{from_date: @from_date, days: @days}.compact)
    end

    def watching
      shows = TvShow.all
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
      @trakt_calendar ||= Services::Trakt::Calendars.new(token: Credential.find_by_name(:trakt).data['access_token'])
    end

    class WatchingShow < SimpleDelegator
      def initialize(tv_show, calendar_episode)
        @tv_show = tv_show
        super calendar_episode
      end

      def poster
        @tv_show.trakt_details[:images][:poster][:thumb]
      end
    end
  end
end
