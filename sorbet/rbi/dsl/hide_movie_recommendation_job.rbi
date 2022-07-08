# typed: strict

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `HideMovieRecommendationJob`.
# Please instead update this file by running `bin/tapioca dsl HideMovieRecommendationJob`.

class HideMovieRecommendationJob
  class << self
    sig { params(movie_recommendation: T.untyped).returns(T.any(HideMovieRecommendationJob, FalseClass)) }
    def perform_later(movie_recommendation); end

    sig { params(movie_recommendation: T.untyped).returns(T.untyped) }
    def perform_now(movie_recommendation); end
  end
end
