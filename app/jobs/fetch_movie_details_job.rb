class FetchMovieDetailsJob < ActiveJob::Base
  queue_as :omdb

  def perform(movie)
    ActiveRecord::Base.connection_pool.with_connection do
      fetch_details(movie)
    end
  end

  private

  def fetch_details(movie)
    return
    omdb_movie = Omdb::Api.new.find(movie.imdb_id, true)[:movie]
    return unless omdb_movie.present?
    data = omdb_movie.public_methods(false).each_with_object({}) do |method, data|
      data[method] = omdb_movie.public_send(method)
    end

    movie.update_attributes(title: data[:title], omdb_details: data)
  end
end
