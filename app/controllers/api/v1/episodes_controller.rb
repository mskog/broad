module Api
  module V1
    class EpisodesController < ApplicationController
      def index
        episodes = ViewObjects::Episodes.from_params(params)
        view = EpisodeDecorator.decorate_collection(episodes.with_release.paginate(page: params[:page], per_page: params.fetch(:per_page, 20)))
        render json: view.map{|episode| episode.as_json.merge(name: episode.tv_show.name, still: episode.still)}
      end

      def show
        episode = Domain::BTN::Episode.new(Episode.find(params[:id]))
        view = EpisodeDecorator.decorate(episode)
        render json: view.as_json.merge(name: view.tv_show.name, still: view.still)
      end
    end
  end
end
