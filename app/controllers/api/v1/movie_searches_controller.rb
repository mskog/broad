class Api::V1::MovieSearchesController < Api::ApiController
  def index
    query = params[:query]
    @view = MovieSearchResultDecorator.decorate_collection Services::MovieSearch.new(query)
    respond_to do |format|
      format.json {render json: @view.to_json}
    end
  end
end
