module Mutations
  # TODO: Validation. Cannot be run if release not available
  class ForceMovieDownload < BaseMutation
    argument :id, Integer, required: true

    type Types::MovieType

    def resolve(id:)
      movie = Movie.find(id)
      movie.update(waitlist: false, download_at: Time.now)
      movie
    end
  end
end
