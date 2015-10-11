module Services
  class SearchForAndPersistMovieRelease
    def initialize(movie)
      @movie = Domain::PTP::Movie.new(movie)
    end

    def perform
      ptp_movie = Services::PTP::Api.new.search(@movie.imdb_id).movie
      return unless ptp_movie.releases.count > 0
      @movie.set_attributes(ptp_movie)
      @movie.fetch_new_releases(ptp_movie)
      @movie.save
    end
  end
end
