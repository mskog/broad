class MoviePostersController < ApplicationController
  include ImageHelper

  def show
    tmdb_images = Rails.cache.fetch("tmdb_poster_images_#{params[:id]}") do
      Tmdb::Movie.images(params[:id])
    end
    images = MoviePostersDecorator.decorate tmdb_images
    redirect_to images.url, :status => 301
  end
end
