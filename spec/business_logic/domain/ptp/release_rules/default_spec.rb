require 'spec_helper'

describe Domain::PTP::ReleaseRules::Default, :nodb do
  subject{described_class.new(release)}

  describe "#acceptable?" do
    context "with 3d" do
      Given(:release){build_stubbed :movie_release, version_attributes: ['3d']}
      Then{expect(subject).to_not be_acceptable}
    end

    context "with no seeders" do
      Given(:release){build_stubbed :movie_release, seeders: 0}
      Then{expect(subject).to_not be_acceptable}
    end

    context "with a ts source" do
      Given(:release){build_stubbed :movie_release, source: 'ts'}
      Then{expect(subject).to_not be_acceptable}
    end

    context "with a cam source" do
      Given(:release){build_stubbed :movie_release, source: 'cam'}
      Then{expect(subject).to_not be_acceptable}
    end

    context "with a bluray source" do
      Given(:release){build_stubbed :movie_release, source: 'blu-ray'}
      Then{expect(subject).to be_acceptable}
    end

    context "with a dvd source" do
      Given(:release){build_stubbed :movie_release, source: 'dvd'}
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
  end
end
