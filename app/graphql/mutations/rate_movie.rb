module Mutations
  class RateMovie < BaseMutation
    argument :id, ID, required: true
    argument :rating, Integer, required: true

    type Types::MovieType

    def resolve(id:, rating:)
      movie = Movie.find(id)
      movie.update personal_rating: rating
      trakt = Services::Trakt::Sync.new
      trakt.rate_movie(movie.imdb_id, rating)
      movie
    end
  end
end
