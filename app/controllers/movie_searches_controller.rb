class MovieSearchesController < ApplicationController
  def index
  end

  def create
    query = params[:query]
    result = Omdb::Api.new.search(query)
    raise StandardError if result[:status] != 200
    @view = result[:movies]
  end
end
