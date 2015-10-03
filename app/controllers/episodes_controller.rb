class EpisodesController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_USERNAME'], password: ENV['HTTP_PASSWORD'], except: :download

  def index
    @view = Episode.eager_load(:releases).where("episodes.published_at < ?", ENV['DELAY_HOURS'].to_i.hours.ago).order(id: :desc).limit(100).map do |episode|
      Domain::BTN::Episode.new(episode)
    end

    respond_to do |format|
      format.rss {render :layout => false}
    end
  end

  def download
    @view = Domain::BTN::Episode.new(Episode.find_by(id: params[:id], key: params[:key]))
    redirect_to @view.best_release.url
  end
end
