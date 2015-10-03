module Services
  class SearchForAndPersistMovieRelease
    def initialize(imdb_url)
      @imdb_url = imdb_url
    end

    def perform
      ptp_movie = Services::PTP::Api.new.search_by_imdb_url(@imdb_url).movie
      return unless ptp_movie.releases.count > 0
      movie = Movie.create(title: ptp_movie.title)
      ptp_movie.releases.each do |release|
        movie.movie_releases.create!(release.to_h.except(:id, :width, :height).merge(ptp_movie_id: release.id, auth_key: ptp_movie.auth_key))
      end
    end
  end
end
