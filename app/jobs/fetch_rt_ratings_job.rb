class FetchRtRatingsJob < ActiveJob::Base
  queue_as :spoiled

  def perform(movie)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_ratings(movie)
      sleep 10 unless Rails.env.test?
    end
  end

  private

  def fetch_ratings(movie)
    movie.rt_critics_rating = ::Services::Spoiled.new(movie.title).score
    movie.save!
  end
end
