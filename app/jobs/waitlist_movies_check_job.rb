# TODO Specs
class WaitlistMoviesCheckJob < ActiveJob::Base
  queue_as :default

  def perform
    Movie.on_waitlist.each do |movie|
      WaitlistMovieCheckJob.set(wait: rand(3600).seconds).perform_later(movie)
    end
  end
end
