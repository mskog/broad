class MovieDownloadsController < ApplicationController
  def new
    render 'new'
  end

  def create
    imdb = Services::Imdb.from_data(create_params[:query])
    @movie = Domain::PTP::Movie.new(Movie.find_or_initialize_by(imdb_id: imdb.id))
    @movie.fetch_new_releases
    if @movie.has_acceptable_release?
      create_acceptable_release
    else
      create_unacceptable_release
    end
  end

  def index
    @view = Movie.downloadable.order(id: :desc).limit(100)
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

  def create_acceptable_release
    @movie.save
    redirect_to movie_downloads_path and return
  end

  def create_unacceptable_release
  end

  def create_params
    params.permit(:query)
  end
end
