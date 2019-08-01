class Api::V1::MovieWaitlistsController < Api::ApiController
  def create
    movie = Movie.find_or_create_by(imdb_id: create_params[:imdb_id]) do |mov|
      mov.waitlist = true
    end
    CheckWaitlistMovieJob.perform_later movie
    head 200
  end

  def destroy
    @view = Movie.find(params[:id])
    if @view.deletable?
      @view.destroy
      head 204
    else
      head 422
    end
  end

  def force
    movie = movie_scope.find_by(id: params[:id])
    movie.update_attributes(waitlist: false, download_at: Time.now)
    head :ok
  end

  private

  def create_params
    params.require(:imdb_id)
    params.permit(:imdb_id)
  end

  def movie_scope
    Movie.on_waitlist
  end
end
