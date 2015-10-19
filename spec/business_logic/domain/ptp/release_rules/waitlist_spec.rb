require 'spec_helper'

describe Domain::PTP::ReleaseRules::Waitlist, :nodb do
  subject{described_class.new(release)}

  describe "#acceptable?" do
    context "with 3d" do
      Given(:release){build_stubbed :movie_release, version_attributes: ['3d']}
      Then{expect(subject).to_not be_acceptable}
    end

    context "with 3d half sbs" do
      Given(:release){build_stubbed :movie_release, version_attributes: ['3d_half_sbs']}
      Then{expect(subject).to_not be_acceptable}
    end

    context "with source not bluray" do
      Given(:release){build_stubbed :movie_release, source: 'dvd'}
      Then{expect(subject).to_not be_acceptable}
    end

    context "with a bluray source" do
      Given(:release){build_stubbed :movie_release, source: 'blu-ray'}
      Then{expect(subject).to be_acceptable}
    end

    context "with a release with commentary" do
      Given(:release){build_stubbed :movie_release, version_attributes: ['with_commentary']}
      Then{expect(subject).to_not be_acceptable}
    end

    context "with a release with extras" do
      Given(:release){build_stubbed :movie_release, version_attributes: ['extras']}
      Then{expect(subject).to_not be_acceptable}
    end

    context "with a non mkv container" do
      Given(:release){build_stubbed :movie_release, container: 'm2ts'}
      Then{expect(subject).to_not be_acceptable}
    end
  end
end
