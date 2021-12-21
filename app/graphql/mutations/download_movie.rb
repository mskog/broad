module Mutations
  class DownloadMovie < BaseMutation
    argument :imdb_id, String, required: true

    type Types::MovieType

    def resolve(imdb_id:)
      movie = Domain::PTP::Movie.new(Movie.find_or_initialize_by(imdb_id: imdb_id))
      movie.download_at = DateTime.now
      movie.fetch_new_releases
      movie.save if movie.has_acceptable_release?
      movie
    end
  end
end
