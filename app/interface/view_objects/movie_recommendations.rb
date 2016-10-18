module ViewObjects
  class MovieRecommendations
    include Enumerable

    def each(&block)
      recommendations.each(&block)
    end

    private

    def recommendations
      @recommendations ||= Services::Trakt::Recommendations.new(token: Credential.find_by_name(:trakt).data['access_token']).movies
    end
  end
end
