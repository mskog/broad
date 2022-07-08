# typed: true
module Services
  class FetchNewMovieReleases
    def initialize(movie)
      @movie = movie
    end

    def perform
      @movie.fetch_new_releases
      @movie.save
    end
  end
end
