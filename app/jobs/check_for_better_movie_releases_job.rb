# typed: false

class CheckForBetterMovieReleasesJob < ActiveJob::Base
  extend T::Sig

  queue_as :ptp

  sig{returns(T.untyped)}
  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      Movie.check_for_better_releases_than_downloaded
    end
  end
end
