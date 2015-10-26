class EpisodesController < ApplicationController
  def index
    episodes = ViewObjects::Episodes.from_params(params)
    respond_index(episodes)
  end

  def download
    @view = Domain::BTN::Episode.new(Episode.find_by(id: params[:id], key: params[:key]))
    redirect_to @view.best_release.url
  end

  private

  def respond_index(episodes)
    respond_to do |format|
      format.html{@view = EpisodeDecorator.decorate_collection(episodes.paginate(page: params[:page]))}
      format.rss {@view = EpisodeDecorator.decorate_collection(episodes.downloadable.limit(100)); render :layout => false}
    end
  end
end
