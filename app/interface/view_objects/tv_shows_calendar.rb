module ViewObjects
  class TvShowsCalendar < SimpleDelegator
    def initialize(from_date: nil, days: nil)
      @from_date = from_date
      @days = days
      credential = Credential.find_by_name :trakt
      @trakt_calendar = Services::Trakt::Calendars.new(token: credential.data['access_token'])
    end

    def episodes
      @trakt_calendar.shows(**{from_date: @from_date, days: @days}.compact)
    end
  end
end
