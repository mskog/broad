class MovieDownloadsController < ApplicationController
  def new
    render 'new'
  end

  def create
    @view = Domain::PTP::Movie.new(build_movie)
    @view.fetch_new_releases
    @view.has_acceptable_release? ? create_acceptable_release : create_unacceptable_release
  end

  def index
    movies = Movie.eager_load(:releases).downloadable.order(id: :desc).limit(100).map do |movie|
      Domain::PTP::Movie.new(movie)
    end

    @view = MovieDecorator.decorate_collection movies

    respond_index
  end

  def download
    movie = Movie.eager_load(:releases).find_by(id: params[:id], key: params[:key])
    @view = Domain::PTP::Movie.new(movie)
    redirect_to @view.best_release.download_url
  end

  private

  def respond_index
    respond_to do |format|
      format.rss {render :layout => false}
      format.html
    end
  end

  def build_movie
    imdb = Services::Imdb.from_data(create_params[:query])
    Movie.find_or_initialize_by(imdb_id: imdb.id)
  end

  def create_acceptable_release
    @view.save
    redirect_to movie_downloads_path and return
  end

  def create_unacceptable_release
  end

  def create_params
    params.permit(:query)
  end
end
