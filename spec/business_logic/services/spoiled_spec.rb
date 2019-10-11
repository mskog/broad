require "spec_helper"

describe Services::Spoiled do
  subject{described_class.new(title)}

  describe "#tomatometer" do
    Given(:title){"Alien"}
    When(:result){subject.tomatometer}
    Then{expect(result).to be_between(1, 100)}
  end

  describe "#audience_score" do
    Given(:title){"Alien"}
    When(:result){subject.audience_score}
    Then{expect(result).to be_between(1, 100)}
  end
end
