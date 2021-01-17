module Mutations
  # TODO: Validation. Cannot be run if release not available
  class ForceMovieDownload < BaseMutation
    argument :id, ID, required: true

    type Types::MovieType

    def resolve(id:)
      movie = Movie.find(id)
      movie.update_attributes(waitlist: false, download_at: Time.now)
      Domain::PTP::Movie.new(movie)
    end
  end
end
