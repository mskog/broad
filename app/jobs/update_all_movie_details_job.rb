class UpdateAllMovieDetailsJob < ActiveJob::Base
  queue_as :default

  def perform
    Movie.on_waitlist.each do |movie|
      FetchMovieDetailsJob.perform_later movie
    end
  end
end
