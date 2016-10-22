module ViewObjects
  class MovieRecommendations
    include Enumerable

    def each(&block)
      recommendations.each(&block)
    end

    private

    def recommendations
      @recommendations ||= MovieRecommendation.all
    end
  end
end
