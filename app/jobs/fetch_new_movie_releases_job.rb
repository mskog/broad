# typed: true
class FetchNewMovieReleasesJob < ActiveJob::Base
  queue_as :default

  def perform(movie)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_releases(movie)
    end
  end

  private

  def fetch_releases(movie)
    Services::FetchNewMovieReleases.new(movie).perform
  end
end
