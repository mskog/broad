class MovieOverwatchesController < ApplicationController
  def new
    render 'new'
  end

  def create
  end

  def index
    @view = Movie.on_overwatch.order(id: :desc).limit(100)
    respond_to do |format|
      format.html
    end
  end

  private

  def create_params
    params.permit(:query)
  end
end
