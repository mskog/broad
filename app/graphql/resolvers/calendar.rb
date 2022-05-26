class Resolvers::Calendar < Resolvers::Base
  type [Types::CalendarItemType], null: false

  argument :category, type: Types::CalendarCategory, required: false

  def resolve(category: nil)
    data = case category
           when "MOVIES"
             upcoming_movie_release_dates
           when "EPISODES"
             ViewObjects::TvShowsCalendar.new(cache_key_prefix: "watching").watching.episodes
           else
             (upcoming_movie_release_dates + ViewObjects::TvShowsCalendar.new(cache_key_prefix: "watching").watching.episodes)
           end

    # TODO: Eww
    data.sort_by do |item|
      item.try(:first_aired) || item.try(:release_date)
    end
  end

  private

  def upcoming_movie_release_dates
    Movie.upcoming.flat_map do |movie|
      movie.release_dates.upcoming
    end
  end
end
