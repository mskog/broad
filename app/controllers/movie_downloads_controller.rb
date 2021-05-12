class MovieDownloadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def download
    movie = Movie.eager_load(:releases).find_by(id: params[:id], key: params[:key])
    @view = Domain::PTP::Movie.new(movie)
    redirect_to @view.download
  end
end
