class WatchedMoviesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @view = MovieDecorator.decorate_collection ViewObjects::Movies.watched.paginate(page: params[:page])
  end
end
