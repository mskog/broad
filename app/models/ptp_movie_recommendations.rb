# typed: ignore

class PtpMovieRecommendations
  extend T::Sig

  include Enumerable

  MINIMUM_RATING = 70

  sig{params(recommendations: T.untyped).void}
  def initialize(recommendations = Broad::ServiceRegistry.ptp_api.top)
    @recommendations = recommendations
  end

  def each(&block)
    @recommendations.each(&block)
  end

  sig{params(minimum_rating: Integer).returns(PtpMovieRecommendations)}
  def with_minimum_rating(minimum_rating = MINIMUM_RATING)
    @recommendations = @recommendations.select{|top_movie| top_movie.ptp_rating.to_i >= minimum_rating}
    self
  end

  sig{returns(PtpMovieRecommendations)}
  def not_downloaded
    @recommendations = @recommendations.reject do |top_movie|
      ::Movie.find_by(imdb_id: top_movie.imdb_id).present?
    end
    self
  end

  sig{params(year: T.any(Integer, String)).returns(PtpMovieRecommendations)}
  def since_year(year)
    @recommendations = @recommendations.reject do |top_movie|
      top_movie.year.to_i <= year
    end
    self
  end
end
