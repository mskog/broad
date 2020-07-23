module Mutations
  class RateMovie < BaseMutation
    argument :id, ID, required: true
    argument :rating, Integer, required: true

    type Types::MovieType

    def resolve(id:, rating:)
      movie = Movie.find(id)
      movie.update personal_rating: rating
      RateMovieJob.perform_later(movie, rating)
      movie
    end
  end
end
