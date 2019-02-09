module Api
  module V1
    class PostersController < ApplicationController
      def show
        type_klass = params.key?(:type) && params[:type] == 'tv_show' ? Tmdb::TV : Tmdb::Movie

        tmdb_images = Rails.cache.fetch("tmdb_poster_images_#{params[:id]}") do
          type_klass.images(params[:id])
        end
        images = PostersDecorator.decorate tmdb_images
        render json: {url: images.url}
      end
    end
  end
end


