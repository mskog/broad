# typed: false

class FetchMovieImagesJob < ActiveJob::Base
  extend T::Sig

  queue_as :trakt

  sig{params(movie: Movie).void}
  def perform(movie)
    ActiveRecord::Base.connection_pool.with_connection do
      movie.fetch_images
      sleep 1 unless Rails.env.to_sym == :test
    end
  end
end
