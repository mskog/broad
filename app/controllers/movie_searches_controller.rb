class MovieSearchesController < ApplicationController
  def index
  end

  def create
    query = params[:query]
    @view = MovieSearchResultDecorator.decorate_collection Services::MovieSearch.new(query)
  end
end
