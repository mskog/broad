class CheckWaitlistMovieJob < ActiveJob::Base
  sidekiq_options retry: false

  def perform(movie)
    ActiveRecord::Base.connection_pool.with_connection do
      Services::WaitlistMoviesCheck.new(movie).perform
    end
  end
end
