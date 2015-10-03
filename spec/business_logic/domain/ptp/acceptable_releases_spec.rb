require 'spec_helper'

describe Domain::PTP::AcceptableReleases do
  subject{described_class.new(releases)}

  describe "Enumerate" do
    When(:result){subject.to_a}

    context "with a release with no seeders" do
      Given(:releases) do
        [
          OpenStruct.new(seeders: 5),
          OpenStruct.new(seeders: 0),
        ]
      end

      Then{expect(result).to contain_exactly releases.first}
    end
  end
end
