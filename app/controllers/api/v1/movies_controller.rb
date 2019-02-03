class Api::V1::MoviesController < Api::ApiController
  def index
    @view = ViewObjects::Movies.watched
    json = Rails.cache.fetch(@view.cache_key) do
      @view.to_json
    end

    respond_to do |format|
      format.json {render json: json}
    end
  end
end
