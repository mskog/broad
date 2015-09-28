class MovieReleasesController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_USERNAME'], password: ENV['HTTP_PASSWORD'], except: :download

  def create
    Services::SearchForAndPersistMovieRelease.new(create_params[:imdb_url]).perform
  end

  private

  def create_params
    params.permit(:imdb_url)
  end
end
