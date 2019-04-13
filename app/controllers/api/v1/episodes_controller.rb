module Api
  module V1
    class EpisodesController < ApplicationController
      def index
        episodes = ViewObjects::Episodes.from_params(params)
        view = EpisodeDecorator.decorate_collection(episodes.with_release.paginate(page: params[:page], per_page: params.fetch(:per_page, 20)))

        render json: view.map{|episode| episode.as_json.merge(still: episode.still(500))}
      end
      private

      def respond_index(episodes)
        respond_to do |format|
          format.html{@view = EpisodeDecorator.decorate_collection(episodes.with_release.paginate(page: params[:page]))}
          format.rss {@view = EpisodeDecorator.decorate_collection(episodes.downloadable.with_release.with_distinct_releases.limit(100)); render :layout => false}
        end
      end
    end
  end
end
