class PostersController < ApplicationController
  def self.setup_auth; end

  include ImageHelper

  def show
    type_klass = params.key?(:type) && params[:type] == "tv_show" ? Tmdb::TV : Tmdb::Movie

    tmdb_images = Rails.cache.fetch("tmdb_poster_images_#{params[:id]}") do
      type_klass.images(params[:id])
    end
    images = PostersDecorator.decorate tmdb_images
    redirect_to images.url, :status => 301
  end
end
