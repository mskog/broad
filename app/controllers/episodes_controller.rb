class EpisodesController < ApplicationController
  def index
    @view = Episode
            .downloadable
            .with_release
            .with_distinct_releases
            .order(id: :desc)
            .limit(100)

    respond_to do |format|
      format.rss{render :layout => false}
    end
  end

  # TODO: Will blow up if there is no release!
  def download
    @view = Domain::Btn::Episode.new(Episode.find_by(id: params[:id], key: params[:key]))

    data = Rails.cache.fetch("episode-download-#{@view.best_available_release.url}", expires_in: 90.days) do
      tempfile = Down.download(@view.best_available_release.url)
      tempfile.read
    end

    send_data data, disposition: :attachment, filename: "torrent.torrent"
  end
end
