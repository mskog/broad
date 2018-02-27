class SyncRatedMoviesWithTraktJob < ActiveJob::Base
  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      ::Services::SyncRatedMoviesWithTrakt.new.perform
    end
  end
end
