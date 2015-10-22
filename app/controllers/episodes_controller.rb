class EpisodesController < ApplicationController
  def index
    @view = EpisodeDecorator.decorate_collection Episode.eager_load(:releases).where("episodes.published_at < ?", ENV['DELAY_HOURS'].to_i.hours.ago).order(id: :desc).limit(100).map do |episode|
      Domain::BTN::Episode.new(episode)
    end
    respond_index
  end

  def download
    @view = Domain::BTN::Episode.new(Episode.find_by(id: params[:id], key: params[:key]))
    redirect_to @view.best_release.url
  end

  private

  def respond_index
    respond_to do |format|
      format.html
      format.rss {render :layout => false}
    end
  end
end
