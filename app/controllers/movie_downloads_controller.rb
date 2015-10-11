class MovieDownloadsController < ApplicationController
  def new
    render 'new'
  end

  def create
    Services::SearchForAndPersistMovieRelease.new(create_params[:imdb_url]).perform
    redirect_to movie_downloads_path
  end

  def index
    @view = Movie.order(id: :desc).limit(100)
    respond_to do |format|
      format.rss {render :layout => false}
      format.html
    end
  end

  def download
    movie = Movie.eager_load(:releases).find_by(id: params[:id], key: params[:key])
    @view = Domain::PTP::Movie.new(movie)
    redirect_to @view.best_release.download_url
  end

  private

  def create_params
    params.permit(:imdb_url)
  end
end
