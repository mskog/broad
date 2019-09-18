class MovieDownloadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @view = MovieDecorator.decorate_collection(ViewObjects::Movies.downloadable.paginate(page: params[:page]))
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
      format.rss{render :layout => false}
    end
  end
end
