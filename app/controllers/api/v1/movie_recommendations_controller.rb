class Api::V1::MovieRecommendationsController < Api::ApiController
  def index
    @view = ViewObjects::MovieRecommendations.new
    respond_to do |format|
      format.json {render json: @view.to_json}
    end
  end

  def download
    movie_recommendation = MovieRecommendation.find(params[:id])
    movie = Movie.find_or_create_by(imdb_id: movie_recommendation.imdb_id) do |mov|
      mov.waitlist = true
    end
    CheckWaitlistMovieJob.perform_later movie
    head :ok
  end
end
