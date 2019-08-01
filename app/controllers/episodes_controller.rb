class EpisodesController < ApplicationController
  def index
    episodes = ViewObjects::Episodes.from_params(params)
    respond_index(episodes)
  end

  # TODO: Will blow up if there is no release!
  def download
    @view = Domain::BTN::Episode.new(Episode.find_by(id: params[:id], key: params[:key]))
    redirect_to @view.best_available_release.url
  end

  private

  def respond_index(episodes)
    respond_to do |format|
      format.html{@view = EpisodeDecorator.decorate_collection(episodes.with_release.paginate(page: params[:page]))}
      format.rss{@view = EpisodeDecorator.decorate_collection(episodes.downloadable.with_release.with_distinct_releases.limit(100)); render :layout => false}
    end
  end
end
