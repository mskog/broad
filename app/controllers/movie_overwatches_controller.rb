class MovieOverwatchesController < ApplicationController
  def new
    render 'new'
  end

  def create
    imdb = Services::Imdb.from_data(create_params[:query])
    movie = Movie.find_or_create_by(imdb_id: imdb.id, overwatch: true)
    FetchNewMovieReleasesJob.perform_later movie
    redirect_to movie_overwatches_path
  end

  def index
    @view = Movie.on_overwatch.order(id: :desc).limit(100)
    respond_to do |format|
      format.html
    end
  end

  private

  def create_params
    params.permit(:query)
  end
end
