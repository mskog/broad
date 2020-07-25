class Resolvers::BestMovies < Resolvers::Base
  type [Types::MovieType], null: false

  argument :year, type: Integer, required: false
  argument :limit, type: Integer, required: false

  def resolve(year: nil, limit: 10)
    scope = Movie
            .watched
            .order("movies.personal_rating DESC NULLS LAST, movies.trakt_rating DESC")
            .limit(limit)
    scope = scope.where("extract(year from movies.release_date) = ?", year) if year.present?
    MovieDecorator.decorate_collection ViewObjects::Movies.new(scope)
  end
end
