module Api
  module V1
    class TvShowsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        @view = TvShowDecorator.decorate_collection(ViewObjects::TvShows
                .from_params(params)
                .paginate(page: params.fetch(:page, 1), per_page: params.fetch(:per_page, 20)))

        respond_to do |format|
          format.json {render json: @view}
        end
      end

      def show
        @view = TvShowDecorator.decorate(ViewObjects::TvShow
                .new(tv_show))

        respond_to do |format|
          format.json {render json: @view, serializer: TvShowSerializer}
        end
      end

      def collect
        tv_show.update(collected: true, watching: true)
        # Wait for an hour to make sure the details have been downloaded
        CollectTvShowJob.set(wait: 1.hour).perform_later(tv_show)
        show
      end

      private

      def tv_show
        @tv_show ||= TvShow.find(params[:id])
      end
    end
  end
end
