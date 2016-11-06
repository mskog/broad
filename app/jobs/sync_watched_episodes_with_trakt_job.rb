class SyncWatchedEpisodesWithTraktJob < ActiveJob::Base
  def perform
    ActiveRecord::Base.connection_pool.with_connection do
      ::Services::SyncWatchedEpisodesWithTrakt.new.perform
    end
  end
end
