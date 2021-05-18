class MovieDownloadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @view = ViewObjects::Movies.downloadable.paginate(page: params[:page])
    respond_to do |format|
      format.rss{render :layout => false}
    end
  end

  def download
    movie = Movie.eager_load(:releases).find_by(id: params[:id], key: params[:key])
    @view = Domain::PTP::Movie.new(movie)
    redirect_to @view.download
  end
end
