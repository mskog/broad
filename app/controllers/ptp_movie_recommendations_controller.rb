class PtpMovieRecommendationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  caches_action :index, expires_in: 1.day

  def index
    @movie_recommendations = PtpMovieRecommendations
                             .new
                             .not_downloaded
                             .with_minimum_rating
                             .since_year(3.years.ago.year)

    respond_to do |format|
      format.json{render json: @movie_recommendations.as_json}
      format.rss
    end
  end
end
