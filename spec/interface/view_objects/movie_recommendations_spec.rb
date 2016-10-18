require 'spec_helper'

describe ViewObjects::MovieRecommendations do
  subject{described_class.new}

  Given!(:credential){create :credential, name: 'trakt'}

  describe "Enumeration" do
    When(:result){subject.to_a}
    Then{expect(result.count).to eq 10}
    And{expect(result.first.title).to eq 'Strange Days'}
  end
end
