# typed: true

class EpisodesController < ApplicationController
  def index
    @view = Episode
            .unwatched
            .downloadable
            .with_release
            .with_distinct_releases
            .order(Arel.sql("download_at IS NOT NULL DESC, download_at desc, id desc"))
            .limit(25)

    respond_to do |format|
      format.rss{render :layout => false}
    end
  end

  # TODO: Will blow up if there is no release!
  def download
    @view = Episode.find_by!(id: params[:id], key: params[:key])

    url = @view.download

    raise ActionController::RoutingError, "Not Found" if @view.best_release.blank?

    data = Rails.cache.fetch("episode-download-#{url}", expires_in: 90.days) do
      tempfile = Down.download(url)
      tempfile.read
    end

    send_data data, disposition: :attachment, filename: "torrent.torrent"
  end
end
