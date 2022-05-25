class FetchMovieReleaseDatesJob < ActiveJob::Base
  queue_as :n8n

  def perform(movie)
    sleep 5 unless Rails.env.test?
    movie.fetch_release_dates
  end
end
