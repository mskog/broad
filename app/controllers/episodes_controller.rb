class EpisodesController < ApplicationController
  def index
    @view = EpisodeDecorator.decorate_collection ViewObjects::Episodes.from_params(params)
    respond_to do |format|
      format.html
      format.rss {render :layout => false}
    end
  end

  def download
    @view = Domain::BTN::Episode.new(Episode.find_by(id: params[:id], key: params[:key]))
    redirect_to @view.best_release.url
  end
end
