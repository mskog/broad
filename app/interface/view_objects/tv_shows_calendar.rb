module ViewObjects
  class TvShowsCalendar < SimpleDelegator
    def initialize(from_date: nil, days: nil, cache_key_prefix: nil)
      @from_date = from_date.presence || Date.today.at_beginning_of_week
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
      imdb_ids = TvShow.pluck :imdb_id
      @episodes = episodes.select do |episode|
        imdb_ids.include? episode.show.ids.imdb
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
  end
end
