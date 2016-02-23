module ViewObjects
  class TvShowsCalendar < SimpleDelegator
    def initialize(from_date: nil, days: nil)
      @from_date = from_date
      @days = days
      credential = Credential.find_by_name :trakt
      @trakt_calendar = Services::Trakt::Calendars.new(token: credential.data['access_token'])
    end

    def episodes
      @episodes ||= Episodes.new(@trakt_calendar.shows(**{from_date: @from_date, days: @days}.compact))
    end

    def cache_key
      ['viewobjects', 'tv_shows_calendar', @from_date.try(:to_time).try(:to_i), @days, Date.today.to_time.to_i].compact.join('-')
    end

    private

    class Episodes
      include Enumerable

      def initialize(data)
        @data = data
      end

      def each(&block)
        @data.each do |result|
          attributes = {
            imdb_id: result['episode']['ids']['imdb'],
            trakt_id: result['episode']['ids']['trakt'],
            season: result['episode']['season'],
            number: result['episode']['number'],
            title: result['episode']['title'],
            first_aired: result['first_aired'],
            show_title: result['show']['title'],
          }
          yield Episode.new(attributes)
        end
      end
    end

    class Episode
      include Virtus.model
      attribute :show_title, String
      attribute :season, Integer
      attribute :number, Integer
      attribute :title, String

      attribute :imdb_id, Integer
      attribute :trakt_id, Integer
      attribute :first_aired, Date

    end
  end
end
