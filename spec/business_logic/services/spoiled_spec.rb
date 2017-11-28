require 'spec_helper'

describe Services::Spoiled do
  subject{described_class.new(title)}

  describe "#score" do
    Given(:title){"Alien"}
    When(:result){subject.score}
    Then{expect(result).to be_between(1,100)}
  end
end
