class HideMovieRecommendationJob < ActiveJob::Base
  queue_as :trakt

  def perform(movie_recommendation)
    recommendations = Services::Trakt::Recommendations.new(token: ::Credential.find_by_name(:trakt).data['access_token'])
    recommendations.hide_movie(movie_recommendation.trakt_id)
    movie_recommendation.destroy
  end
end
