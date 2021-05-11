class PTPMovieRecommendations
  include Enumerable

  MINIMUM_RATING = 70

  def initialize(recommendations = Broad::ServiceRegistry.ptp_api.top)
    @recommendations = recommendations
  end

  def each(&block)
    @recommendations.each(&block)
  end

  def with_minimum_rating(minimum_rating = MINIMUM_RATING)
    @recommendations = @recommendations.select{|top_movie| top_movie.ptp_rating.to_i >= minimum_rating}
    self
  end

  def not_downloaded
    @recommendations = @recommendations.reject do |top_movie|
      ::Movie.find_by(imdb_id: top_movie.imdb_id).present?
    end
    self
  end
end
