module ViewObjects
  class MovieRecommendations
    include Enumerable

    def each(&block)
      recommendations.each(&block)
    end

    private

    def recommendations
      @recommendations ||= begin
        MovieRecommendation
          .where
          .not(imdb_id: Movie.pluck(:imdb_id), trakt_rating: nil)
          .order("movie_recommendations.trakt_rating DESC")
          .limit(20)
      end
    end
  end
end
