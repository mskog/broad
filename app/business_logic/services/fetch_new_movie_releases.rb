module Services
  class FetchNewMovieReleases
    def initialize(movie)
      @movie = Domain::Ptp::Movie.new(movie)
    end

    def perform
      @movie.fetch_new_releases
      @movie.save
    end
  end
end
