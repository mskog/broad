class TvShowsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @view = TvShowDecorator.decorate_collection(ViewObjects::TvShows
            .from_params(params))
  end

  def show
    @view = TvShowDecorator.decorate ViewObjects::TvShow.from_params(params)
  end

  # TODO Existing tv shows?
  def sample
    Domain::BTN::TvShow
      .create_from_imdb_id(params[:imdb_id])
      .sample
    redirect_to episodes_path
  end
end
