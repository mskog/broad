class CollectTvShowJob < ActiveJob::Base
  def perform(tv_show)
    ActiveRecord::Base.connection_pool.with_connection do
      Domain::BTN::TvShow.new(tv_show).collect
    end
  end
end
