module ViewObjects
  class MovieRecommendations
    include Enumerable

    def each(&block)
      recommendations.each(&block)
    end

    private

    def recommendations
      @recommendations ||= MovieRecommendation.where.not(imdb_id: Movie.pluck(:imdb_id))
    end
  end
end
