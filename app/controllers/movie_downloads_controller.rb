# typed: false

class MovieDownloadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @view = Movie.downloadable.take(20)
    respond_to do |format|
      format.rss{render :layout => false}
    end
  end

  def download
    movie = Movie.eager_load(:releases).find_by!(id: params[:id], key: params[:key])

    url = movie.download

    data = Rails.cache.fetch("movie-download-#{url}", expires_in: 90.days) do
      tempfile = Down.download(url)
      tempfile.read
    end

    send_data data, disposition: :attachment, filename: "torrent.torrent"
  end
end
