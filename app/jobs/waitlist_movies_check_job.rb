# TODO: Specs
class WaitlistMoviesCheckJob < ActiveJob::Base
  queue_as :default

  def perform
    Movie.on_waitlist.each do |movie|
      WaitlistMovieCheckJob.new.perform movie
    end
  end
end
