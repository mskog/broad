module Services
  class SearchForAndPersistMovieRelease
    def initialize(imdb_url)
      @imdb_url = imdb_url
    end

    def perform
      result = Services::PTP::Api.new.search_by_imdb_url(@imdb_url)
      if result.present?
        movie = result.movie
        best_release = movie.best_release
        return nil if best_release.nil?
        MovieRelease.create(title: movie.title, download_url: movie.download_url(best_release))
      end
    end
  end
end
