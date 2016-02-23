module ViewObjects
  class TvShowsCalendar < SimpleDelegator
    def initialize(from_date: nil, days: nil)
      @from_date = from_date
      @days = days
    end

    def episodes
      @episodes ||= trakt_calendar.shows(**{from_date: @from_date, days: @days}.compact)
    end

    def cache_key
      ['viewobjects', 'tv_shows_calendar', @from_date.try(:to_time).try(:to_i), @days, Date.today.to_time.to_i].compact.join('-')
    end

    private

    def trakt_calendar
      @trakt_calendar ||= Services::Trakt::Calendars.new(token: Credential.find_by_name(:trakt).data['access_token'])
    end
  end
end
