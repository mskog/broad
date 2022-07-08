# typed: false

class UpdateAllMovieDetailsJob < ActiveJob::Base
  queue_as :default

  def perform
    Movie.find_each do |movie|
      FetchMovieDetailsJob.perform_later movie
      FetchMovieImagesJob.perform_later movie
    end
  end
end
