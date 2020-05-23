class FetchMovieImagesJob < ActiveJob::Base
  queue_as :trakt

  def perform(movie)
    ActiveRecord::Base.connection_pool.with_connection do
      movie.fetch_images
      sleep 1 unless Rails.env.test?
    end
  end
end
