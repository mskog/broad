class MoviePostersController < ApplicationController
  include ImageHelper

  def show
    images = MoviePostersDecorator.decorate Tmdb::Movie.images(params[:id])
    redirect_to images.url, :status => 301
  end
end
