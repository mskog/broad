class Resolvers::Omnisearch < Resolvers::Base
  argument :query, String, "The search query", required: true

  type [Types::OmnisearchResultType], null: false

  def resolve(query:)
    movies = Movie.kinda_spelled_like(query)
    tv_shows = TvShow.kinda_spelled_like(query)

    (movies.to_a + tv_shows.to_a).shuffle.take(10)
  end
end
