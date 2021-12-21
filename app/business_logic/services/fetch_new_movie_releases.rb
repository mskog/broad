module Services
  class FetchNewMovieReleases
    def initialize(movie)
      @movie = Domain::PTP::Movie.new(movie)
    end

    def perform
      @movie.fetch_new_releases
      @movie.save
    end
  end
end
