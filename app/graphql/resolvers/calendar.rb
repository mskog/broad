class Resolvers::Calendar < Resolvers::Base
  type [Types::CalendarItemType], null: false

  argument :category, type: Types::CalendarCategory, required: false

  def resolve(category: nil)
    data = case category
           when "MOVIES"
             Movie.upcoming
           when "EPISODES"
             ViewObjects::TvShowsCalendar.new(cache_key_prefix: "watching").watching.episodes
           else
             (Movie.upcoming + ViewObjects::TvShowsCalendar.new(cache_key_prefix: "watching").watching.episodes)
           end

    # TODO: Eww
    data.sort_by do |item|
      item.try(:first_aired) || item.try(:available_date)
    end
  end
end
