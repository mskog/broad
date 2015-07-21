class EpisodesController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_USERNAME'], password: ENV['HTTP_PASSWORD'], except: :download

  def index
    @view = Episode.eager_load(:releases).where("episodes.published_at < ?", ENV['DELAY_HOURS'].to_i.hours.ago).order(id: :asc).limit(100).map do |episode|
      Domain::Episode.new(episode)
    end

    respond_to do |format|
      format.rss {render :layout => false}
    end
  end

  def download
    @view = Domain::Episode.new(Episode.find(params[:id]))
    redirect_to @view.best_release.url
    # name = "#{@view.name}.S#{@view.season.to_s.rjust(2,'0')}E#{@view.episode.to_s.rjust(2,'0')}.torrent".gsub(' ', '.')
    # send_data Faraday.get(@view.best_release.url).body, filename: name, type: 'application/x-bittorrent'
  end
end
