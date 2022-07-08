# typed: ignore
class SyncWatchedMoviesWithTraktJob < ActiveJob::Base
  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      ::Services::SyncWatchedMoviesWithTrakt.new.perform
    end
  end
end
