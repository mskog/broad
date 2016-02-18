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
    ptp_service = Services::PTP::Api.new
    movies = movie_scope.eager_load(:releases).order("download_at IS NOT NULL desc, download_at asc, movies.id desc").limit(100).map do |movie|
      Domain::PTP::Movie.new(movie, ptp_api: ptp_service, acceptable_release_rule_klass: Domain::PTP::ReleaseRules::Waitlist)
    end
    @view = MovieDecorator.decorate_collection(movies)
    respond_to do |format|
      format.html
    end
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
