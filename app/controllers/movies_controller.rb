class MoviesController < ApplicationController
  def destroy
    @view = Movie.find(params[:id])
    @view.destroy if @view.deletable?
  end
end
