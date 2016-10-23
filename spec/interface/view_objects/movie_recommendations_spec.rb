require 'spec_helper'

describe ViewObjects::MovieRecommendations do
  subject{described_class.new}

  describe "Enumeration" do
    Given!(:movie_recommendations){create_list :movie_recommendation, 2}
    Given{create :movie, imdb_id: movie_recommendations.last.imdb_id}
    When(:result){subject.to_a}
    Then{expect(result.count).to eq 1}
    And{expect(result.first.title).to eq movie_recommendations.first.title}
  end
end
