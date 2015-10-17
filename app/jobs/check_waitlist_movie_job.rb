class CheckWaitlistMovieJob < ActiveJob::Base
  def perform(movie)
    ActiveRecord::Base.connection_pool.with_connection do
      Services::WaitlistMoviesCheck.new(movie).perform
    end
  end
end
