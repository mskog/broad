# typed: true

class FetchMovieDetailsJob < ActiveJob::Base
  extend T::Sig

  queue_as :trakt

  sig{params(movie: Movie).void}
  def perform(movie)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_details(movie)
      sleep 1 unless Rails.env.to_sym == :test
    end
  end

  private

  # TODO: What if the movie has no imdb_id
  sig{params(movie: Movie).void}
  def fetch_details(movie)
    details = Services::MovieDetails.from_trakt(Services::Trakt::Movies.new.summary(movie.imdb_id))
    return unless details&.has_data?
    movie.attributes = details.to_h

    movie.save!
  end
end
