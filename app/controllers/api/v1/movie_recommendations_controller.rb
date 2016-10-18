class Api::V1::MovieRecommendationsController < Api::ApiController
  def index
    @view = ViewObjects::MovieRecommendations.new
    respond_to do |format|
      format.json {render json: @view.to_json}
    end
  end
end
