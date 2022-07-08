# typed: true
# TODO: Specs
class WaitlistMoviesCheckJob < ActiveJob::Base
  queue_as :ptp

  def perform
    Movie.on_waitlist.each do |movie|
      WaitlistMovieCheckJob.new.perform movie
    end
  end
end
