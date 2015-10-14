class MovieWaitlistsController < ApplicationController
  def new
    render 'new'
  end

  def create
    imdb = Services::Imdb.from_data(create_params[:query])
    movie = Movie.find_or_create_by(imdb_id: imdb.id, waitlist: true)
    FetchNewMovieReleasesJob.perform_later movie
    redirect_to movie_waitlists_path
  end

  def index
    @view = MovieDecorator.decorate_collection(Movie.on_waitlist.order(id: :desc).limit(100))
    respond_to do |format|
      format.html
    end
  end

  private

  def create_params
    params.permit(:query)
  end
end
