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
    spoiled_data = ::Services::Spoiled.new(movie.title)
    movie.rt_critics_rating = spoiled_data.tomatometer
    movie.rt_audience_rating = spoiled_data.audience_score
    movie.save!
  end
end
