require 'spec_helper'

describe ViewObjects::MovieRecommendations do
  subject{described_class.new}

  describe "Enumeration" do
    Given!(:movie_recommendation_no_trakt_rating){create :movie_recommendation, trakt_rating: nil}
    Given!(:movie_recommendation){create :movie_recommendation, trakt_rating: 7}
    When(:result){subject.to_a}
    Then{expect(result.count).to eq 1}
    And{expect(result).to contain_exactly(movie_recommendation)}
  end
end
