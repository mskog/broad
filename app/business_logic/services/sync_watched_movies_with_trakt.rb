module Services
  class SyncWatchedMoviesWithTrakt
    def initialize
      @api = Broad::ServiceRegistry.trakt_user
    end

    def perform
      Movie.where(watched: false, imdb_id: trakt_movie_imdb_ids).update_all watched: true, updated_at: Time.now
    end

    private

    def trakt_movie_imdb_ids
      @api.history_movies.map{|history_movie| history_movie.movie.ids.imdb}
    end
  end
end
