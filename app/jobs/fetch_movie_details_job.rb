class FetchMovieDetailsJob < ActiveJob::Base
  queue_as :trakt

  def perform(movie)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_details(movie)
      sleep 1 unless Rails.env.test?
    end
  end

  private

  # TODO: What if the movie has no imdb_id
  def fetch_details(movie)
    details = Services::MovieDetails.from_trakt(Services::Trakt::Movies.new.summary(movie.imdb_id))
    return unless details.has_data?
    movie.attributes = details.to_h

    movie.available_date = Services::Trakt::Movies.new.release_date(movie.imdb_id)

    movie.save!
  end
end
