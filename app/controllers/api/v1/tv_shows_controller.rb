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
        @view = TvShowDecorator.decorate ViewObjects::TvShow.from_params(params)
      end
    end
  end
end
