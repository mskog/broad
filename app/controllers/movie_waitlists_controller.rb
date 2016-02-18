class MovieWaitlistsController < ApplicationController
  def new
    render 'new'
  end

  def create
    imdb = Services::Imdb.from_data(create_params[:query])
    movie = Movie.find_or_create_by(imdb_id: imdb.id) do |mov|
      mov.waitlist = true
    end
    CheckWaitlistMovieJob.perform_later movie
    redirect_to movie_waitlists_path
  end

  def index
    @view = MovieDecorator.decorate_collection(ViewObjects::Movies.new(movie_scope))
  end

  def force
    movie = movie_scope.find_by(id: params[:id])
    movie.update_attributes(waitlist: false, download_at: Time.now)
    redirect_to movie_waitlists_path
  end

  private

  def movie_scope
    Movie.on_waitlist
  end

  def create_params
    params.permit(:query)
  end
end
