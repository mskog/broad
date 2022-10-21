class Types::BestMovieCategory < Types::BaseEnum
  value "RELEASED", "When the movie was released"
  value "WATCHED", "When the movie was watched"
end

class Resolvers::BestMovies < Resolvers::Base
  type [Types::MovieType], null: false

  argument :category, Types::BestMovieCategory, required: true, default_value: "RELEASED"
  argument :year, type: Integer, required: true
  argument :first, type: Integer, required: false
  argument :skip, type: Integer, required: false

  def resolve(category: nil, year: nil, first: 10, skip: nil)
    scope = Movie
            .watched
            .order("movies.personal_rating DESC NULLS LAST, movies.trakt_rating DESC")
    scope = scope.offset(skip) if skip.present?
    scope = scope.limit(first) if first.present?

    scope = if category == "RELEASED"
              scope.where("extract(year from movies.release_date) = ?", year)
            else
              scope.where("extract(year from movies.watched_at) = ?", year)
            end

    ViewObjects::Movies.new(scope)
  end
end
