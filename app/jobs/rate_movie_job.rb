# typed: true
class RateMovieJob < ActiveJob::Base
  def perform(movie, rating)
    trakt = Services::Trakt::Sync.new
    trakt.rate_movie(movie.imdb_id, rating)
  end
end
