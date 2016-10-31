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
          .not(imdb_id: Movie.pluck(:imdb_id))
          .order("(movie_recommendations.omdb_details->'tomato_meter') IS NOT NULL DESC, movie_recommendations.omdb_details->'tomato_meter' != 'N/A' DESC, movie_recommendations.omdb_details->'tomato_meter' DESC")
          .limit(20)
      end
    end
  end
end
