class FeedController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_USERNAME'], password: ENV['HTTP_PASSWORD']

  def index
    @view = Episode.eager_load(:releases).where("episodes.published_at < ?", ENV['DELAY_HOURS'].to_i.hours.ago).order(id: :asc).limit(100).map do |episode|
      Domain::Episode.new(episode)
    end

    respond_to do |format|
      format.rss {render :layout => false}
    end
  end
end
