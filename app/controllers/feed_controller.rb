class FeedController < ApplicationController
  def index
    @view = Episode.eager_load(:releases).where("episodes.created_at < ?", ENV['DELAY_HOURS'].to_i.hours.ago).order(id: :asc).map do |episode|
      Domain::Episode.new(episode)
    end

    respond_to do |format|
      format.rss {render :layout => false}
    end
  end
end
