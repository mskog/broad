# typed: false

class CollectTvShowJob < ActiveJob::Base
  sidekiq_options retry: false

  def perform(tv_show)
    ActiveRecord::Base.connection_pool.with_connection do
      tv_show.collect
    end
  end
end
