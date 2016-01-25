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
    movies = Movie.eager_load(:releases).on_waitlist.order("download_at IS NOT NULL desc, download_at asc, movies.id desc").limit(100).map do |movie|
      Domain::PTP::Movie.new(movie, acceptable_release_rule_klass: Domain::PTP::ReleaseRules::Waitlist)
    end
    @view = MovieDecorator.decorate_collection(movies)
    respond_to do |format|
      format.html
    end
  end

  def update
    movie = Movie.on_waitlist.find_by(id: update_params[:id])
    params_with_download = update_params.merge(download_at: Time.now)
    movie.update_attributes(params_with_download)
    redirect_to :index
  end

  private

  def create_params
    params.permit(:query)
  end

  def update_params
    params.permit(:id, :waitlist)
  end
end
