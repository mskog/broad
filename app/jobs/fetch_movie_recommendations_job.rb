class FetchMovieRecommendationsJob < ActiveJob::Base
  queue_as :trakt

  def perform
    recommendations = ::Broad::ServiceRegistry.recommendations.movies(limit: 100)
    recommendations.each do |recommendation|
      params = {
        title: recommendation.title,
        year: recommendation.year,
        imdb_id: recommendation.ids.imdb,
        trakt_id: recommendation.ids.trakt,
        tmdb_id: recommendation.ids.tmdb,
        trakt_slug: recommendation.ids.slug
      }
      MovieRecommendation.find_or_create_by(imdb_id: params[:imdb_id]) do |movie_recommendation|
        movie_recommendation.attributes = params
      end
    end
  end
end
