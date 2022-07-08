# typed: true
module Mutations
  class RateMovie < BaseMutation
    argument :id, ID, required: true
    argument :rating, Integer, required: true

    type Types::MovieType

    def resolve(id:, rating:)
      movie = Movie.find(id)
      movie.personal_rating = rating
      movie.attributes = {watched: true, watched_at: Time.zone.now} if movie.watched_at.blank?
      movie.save
      RateMovieJob.perform_later(movie, rating)
      movie
    end
  end
end
