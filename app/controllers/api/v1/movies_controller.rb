class Api::V1::MoviesController < Api::ApiController
  def index
    @view = ViewObjects::Movies.watched
    respond_to do |format|
      format.json {render json: @view.to_json}
    end
  end
end
