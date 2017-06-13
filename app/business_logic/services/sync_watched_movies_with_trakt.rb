module Services
  class SyncWatchedMoviesWithTrakt
    def initialize
      @api = Broad::ServiceRegistry.trakt_user
    end

    def perform
      watched_movies.each do |watched_movie|
        movie = Movie.find_by(watched: false, imdb_id: watched_movie.movie.ids.imdb)
        movie.update watched: true, watched_at: watched_movie.watched_at if movie.present?
      end
    end

    private

    def watched_movies
      @api.history_movies
    end
  end
end
