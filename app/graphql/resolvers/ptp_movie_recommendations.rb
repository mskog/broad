class Resolvers::PTPMovieRecommendations < Resolvers::Base
  type [Types::PtpRecommendedMovieType], null: false

  def resolve
    updated_at = Movie.maximum(:updated_at)
    Rails.cache.fetch("graphql_ptp_movie_recommendations_#{updated_at}", expires_in: 1.day) do
      ::PTPMovieRecommendations
        .new
        .not_downloaded
        .with_minimum_rating
        .since_year(3.years.ago.year)
    end
  end
end
