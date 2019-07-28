module Api
  module V1
    class ImagesController < ApplicationController
      def index
        type = params[:type].presence || "tv_show"
        type_klass = type == 'tv_show' ? Tmdb::TV : Tmdb::Movie

        tmdb_images = Rails.cache.fetch("tmdb_images_#{type}_#{params[:id]}") do
          type_klass.images(params[:id])
        end

        result = tmdb_images.slice('backdrops', 'posters').each_with_object({}) do |(key, group), hash|
          group.each do |image|
            hash[key] ||= []
            hash[key].push image.merge(url: "#{Broad.tmdb_configuration.secure_base_url}original#{image['file_path']}")
          end
        end

        render json: result
      end
    end
  end
end


