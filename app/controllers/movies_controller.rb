class MoviesController < ApplicationController
  def destroy
    @view = Movie.find(params[:id])
    @view.destroy
  end
end
