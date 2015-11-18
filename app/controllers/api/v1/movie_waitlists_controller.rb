class Api::V1::MovieWaitlistsController < Api::ApiController
  def create
    movie = Movie.find_or_create_by(imdb_id: create_params[:imdb_id]) do |movie|
      movie.waitlist = true
    end
    CheckWaitlistMovieJob.perform_later movie
    head 200
  end

  private

  def create_params
    params.require(:imdb_id)
    params.permit(:imdb_id)
  end
end
