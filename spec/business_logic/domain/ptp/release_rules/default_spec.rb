require "spec_helper"

describe Domain::PTP::ReleaseRules::Default, :nodb do
  subject{described_class.new(release)}

  describe "#acceptable?" do
    context "with 3d" do
      Given(:release){build_stubbed :movie_release, version_attributes: ["3d"]}
      Then{expect(subject).not_to be_acceptable}
    end

    context "with 3d half sbs" do
      Given(:release){build_stubbed :movie_release, version_attributes: ["3d_half_sbs"]}
      Then{expect(subject).not_to be_acceptable}
    end

    context "with no seeders" do
      Given(:release){build_stubbed :movie_release, seeders: 0}
      Then{expect(subject).not_to be_acceptable}
    end

    context "with a ts source" do
      Given(:release){build_stubbed :movie_release, source: "ts"}
      Then{expect(subject).not_to be_acceptable}
    end

    context "with a cam source" do
      Given(:release){build_stubbed :movie_release, source: "cam"}
      Then{expect(subject).not_to be_acceptable}
    end

    context "with a bluray source" do
      Given(:release){build_stubbed :movie_release, source: "blu-ray"}
      Then{expect(subject).to be_acceptable}
    end

    context "with a dvd source" do
      Given(:release){build_stubbed :movie_release, source: "dvd"}
      Then{expect(subject).to be_acceptable}
    end

    context "with an mp4 container" do
      Given(:release){build_stubbed :movie_release, container: "mp4"}
      Then{expect(subject).not_to be_acceptable}
    end
  end
end
