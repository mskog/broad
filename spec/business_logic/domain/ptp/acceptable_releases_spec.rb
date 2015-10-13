require 'spec_helper'

describe Domain::PTP::AcceptableReleases, :nodb do
  subject{described_class.new(releases)}

  describe "Enumerate" do
    When(:result){subject.to_a}

    context "with a release with no seeders" do
      Given(:releases) do
        [
          build_stubbed(:movie_release, seeders: 5),
          build_stubbed(:movie_release, seeders: 0),
        ]
      end

      Then{expect(result).to contain_exactly releases.first}
    end

    context "with a 3d release" do
      Given(:releases) do
        [
          build_stubbed(:movie_release, version_attributes: []),
          build_stubbed(:movie_release, version_attributes: ['3d']),
        ]
      end

      Then{expect(result).to contain_exactly releases.first}      
    end
  end
end
