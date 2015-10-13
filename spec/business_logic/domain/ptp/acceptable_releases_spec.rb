require 'spec_helper'

describe Domain::PTP::AcceptableReleases, :nodb do
  subject{described_class.new(releases, rule_klass: Domain::PTP::ReleaseRules::Default)}

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

    context "with only TS and cam releases" do
      Given(:releases) do
        [
          build_stubbed(:movie_release, source: 'ts'),
          build_stubbed(:movie_release, source: 'cam'),
        ]
      end
      Then{expect(result).to be_empty}
    end
  end
end
