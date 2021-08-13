class Resolvers::Calendar < Resolvers::Base
  type [Types::CalendarItemType], null: false

  def resolve
    episodes = ViewObjects::TvShowsCalendar.new(cache_key_prefix: "watching").watching.episodes
    movies = Movie.upcoming

    # TODO: Eww
    (episodes + movies).sort_by do |item|
      item.try(:first_aired) || item.try(:available_date)
    end
  end
end
