require 'spec_helper'

describe ViewObjects::MovieRecommendations do
  subject{described_class.new}

  describe "Enumeration" do
    Given!(:movie_recommendations){create_list :movie_recommendation, 2}
    When(:result){subject.to_a}
    Then{expect(result.count).to eq 2}
    And{expect(result.first.title).to eq movie_recommendations.first.title}
  end
end
