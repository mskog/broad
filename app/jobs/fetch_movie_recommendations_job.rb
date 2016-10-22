class FetchMovieRecommendationsJob < ActiveJob::Base
  queue_as :trakt

  def perform
    recommendations = Services::Trakt::Recommendations.new(token: ::Credential.find_by_name(:trakt).data['access_token']).movies
    recommendations.each do |recommendation|
      params = {
        title: recommendation.title,
        year: recommendation.year,
        imdb_id: recommendation.ids.imdb,
        trakt_id: recommendation.ids.trakt,
        tmdb_id: recommendation.ids.tmdb,
        slug: recommendation.ids.slug,
      }
      MovieRecommendation.find_or_create_by(imdb_id: params[:imdb_id]) do |movie_recommendation|
        movie_recommendation.attributes = params
      end
    end
  end
end
