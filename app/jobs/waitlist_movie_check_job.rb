# typed: false
class WaitlistMovieCheckJob < ActiveJob::Base
  queue_as :ptp

  def perform(movie)
    Services::WaitlistMoviesCheck.new(movie).perform
    sleep 5 unless Rails.env.test?
  end
end
