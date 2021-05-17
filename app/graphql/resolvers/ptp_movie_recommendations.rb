class Resolvers::PTPMovieRecommendations < Resolvers::Base
  type [Types::PtpRecommendedMovieType], null: false

  def resolve
    ::PTPMovieRecommendations
      .new
      .not_downloaded
      .with_minimum_rating
      .since_year(3.years.ago.year)
  end
end
