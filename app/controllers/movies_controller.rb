class MoviesController < ApplicationController
  def show
    @view = MovieDecorator.decorate Domain::PTP::Movie.new(Movie.find(params[:id]))
    render 'movies/show', layout: false
  end

  def destroy
    @view = Movie.find(params[:id])
    @view.destroy if @view.deletable?
  end
end
