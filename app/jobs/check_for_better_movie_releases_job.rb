class CheckForBetterMovieReleasesJob < ActiveJob::Base
  queue_as :ptp

  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      Movie.check_for_better_releases_than_downloaded
    end
  end
end
