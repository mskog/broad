class Resolvers::Omnisearch < Resolvers::Base
  argument :query, String, "The search query", required: true

  type [Types::OmnisearchResultType], null: false

  def resolve(query:)
    movies = Movie.where("title ILIKE :query", query: "%#{query}%")
    tv_shows = TvShow.where("name ILIKE :query", query: "%#{query}%")

    (movies.to_a + tv_shows.to_a).shuffle.take(10)
  end
end
