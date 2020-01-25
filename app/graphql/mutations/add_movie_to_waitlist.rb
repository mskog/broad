module Mutations
  class AddMovieToWaitlist < BaseMutation
    argument :imdb_id, String, required: true

    type Types::MovieType

    def resolve(imdb_id:)
      movie = Movie.find_or_create_by(imdb_id: imdb_id) do |mov|
        mov.waitlist = true
      end
      CheckWaitlistMovieJob.perform_later movie
      movie
    end
  end
end
