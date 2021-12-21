class WaitlistMovieCheckJob < ActiveJob::Base
  queue_as :ptp

  def perform(movie)
    ptp_api = Services::Ptp::Api.new
    Services::WaitlistMoviesCheck.new(movie, ptp_api: ptp_api).perform
    sleep 5 unless Rails.env.test?
  end
end
