module Services
  class SearchForAndPersistMovieRelease
    def initialize(imdb_url)
      @imdb_url = imdb_url
    end

    def perform
      movie = Movie.create
      Services::PTP::Api.new.search_by_imdb_url(@imdb_url).movie.releases.each do |release|
        movie.movie_releases.create!(release.to_h.except(:id, :width, :height).merge(ptp_movie_id: release.id))
      end
    end
  end
end
