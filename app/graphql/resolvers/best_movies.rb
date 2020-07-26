class Resolvers::BestMovies < Resolvers::Base
  type [Types::MovieType], null: false

  argument :year, type: Integer, required: false
  argument :first, type: Integer, required: false
  argument :skip, type: Integer, required: false

  def resolve(year: nil, first: 10, skip: nil)
    scope = Movie
            .watched
            .order("movies.personal_rating DESC NULLS LAST, movies.trakt_rating DESC")
    scope = scope.offset(skip) if skip.present?
    scope = scope.limit(first) if first.present?
    scope = scope.where("extract(year from movies.release_date) = ?", year) if year.present?
    MovieDecorator.decorate_collection ViewObjects::Movies.new(scope)
  end
end
