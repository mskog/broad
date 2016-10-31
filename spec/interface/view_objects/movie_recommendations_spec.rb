require 'spec_helper'

describe ViewObjects::MovieRecommendations do
  subject{described_class.new}

  describe "Enumeration" do
    Given!(:movie_recommendation_no_score){create :movie_recommendation, omdb_details: {tomato_meter: nil}}
    Given!(:movie_recommendation_na){create :movie_recommendation, omdb_details: {tomato_meter: 'N/A'}}
    Given!(:movie_recommendation_low){create :movie_recommendation, omdb_details: {tomato_meter: '60'}}
    Given!(:movie_recommendation_high){create :movie_recommendation, omdb_details: {tomato_meter: '60'}}
    When(:result){subject.to_a}
    Then{expect(result.count).to eq 4}
    And{expect(result).to contain_exactly(movie_recommendation_high, movie_recommendation_low, movie_recommendation_na, movie_recommendation_no_score)}
  end
end
