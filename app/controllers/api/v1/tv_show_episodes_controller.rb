module Api
  module V1
    class TvShowEpisodesController < ApplicationController
      def index
        episodes = ViewObjects::Episodes.from_tv_show_id(params[:tv_show_id])
        view = EpisodeDecorator.decorate_collection(episodes)

        render json: view.map{|episode| episode.as_json.merge(still: episode.still(500))}
      end
    end
  end
end
