# typed: ignore
module Services
  class SyncRatedMoviesWithTrakt
    def initialize
      @api = Broad::ServiceRegistry.trakt_user
    end

    def perform
      rated_movies.each do |rated_movie|
        movie = Movie.find_by(imdb_id: rated_movie.movie.ids.imdb)
        movie.update personal_rating: rated_movie.rating if movie.present?
      end
    end

    private

    def rated_movies
      @api.ratings_movies
    end
  end
end
