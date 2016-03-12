class Api::V1::MovieSearchesController < Api::ApiController
  caches_action :index, expires_in: 1.hour, cache_path: Proc.new {
    api_v1_movie_searches_path(params[:query])
  }

  def index
    query = params[:query]
    @view = MovieSearchResultDecorator.decorate_collection Services::MovieSearch.new(query)
    respond_to do |format|
      format.json {render json: @view.to_json}
    end
  end
end
