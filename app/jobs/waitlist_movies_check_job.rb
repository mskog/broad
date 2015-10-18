class WaitlistMoviesCheckJob < ActiveJob::Base
  queue_as :default

  def perform
    ptp_api = Services::PTP::Api.new
    Movie.on_waitlist.each do |movie|
      Services::WaitlistMoviesCheck.new(movie, ptp_api: ptp_api).perform
      sleep 5 unless Rails.env.test?
    end
  end
end
