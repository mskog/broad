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
    redirect_to @view.best_available_release.url
  end
end
