class MovieSearchesController < ApplicationController
  def index
  end

  def create
    query = params[:query]
    result = Omdb::Api.new.search(query)
    create_response(result)
  end

  private

  def create_response(result)
    status = result[:status]
    if status == 404
      @view = []
    elsif status == 200
      @view = MovieSearchResultDecorator.decorate_collection(result[:movies])
    else
      raise StandardError
    end
  end
end
