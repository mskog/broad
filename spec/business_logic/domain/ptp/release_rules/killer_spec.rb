require "spec_helper"

describe Domain::Ptp::ReleaseRules::Killer, :nodb do
  subject{described_class.new(release)}

  describe "#acceptable?" do
    context "with 3d" do
      Given(:release){build_stubbed :movie_release, remaster_title: "3d"}
      Then{expect(subject).not_to be_acceptable}
    end

    context "with 3d half sbs" do
      Given(:release){build_stubbed :movie_release, remaster_title: "3d_half_sbs"}
      Then{expect(subject).not_to be_acceptable}
    end

    context "with a dvd source" do
      Given(:release){build_stubbed :movie_release, source: "dvd"}
      Then{expect(subject).not_to be_acceptable}
    end

    context "with a bluray source" do
      Given(:release){build_stubbed :movie_release, source: "blu-ray"}
      Then{expect(subject).not_to be_acceptable}
    end

    context "with a web version in 4k" do
      Given(:release){build_stubbed :movie_release, source: "web", resolution: "2160p"}
      Then{expect(subject).to be_acceptable}
    end

    context "with a non mkv container" do
      Given(:release){build_stubbed :movie_release, container: "m2ts"}
      Then{expect(subject).not_to be_acceptable}
    end

    context "with a remux with a non mkv container" do
      Given(:release){build_stubbed :movie_release, container: "m2ts", remaster_title: "remux"}
      Then{expect(subject).not_to be_acceptable}
    end

    context "with a remux with an mkv container and a bluray source" do
      Given(:release){build_stubbed :movie_release, source: "blu-ray", container: "mkv", remaster_title: "remux"}
      Then{expect(subject).to be_acceptable}
    end

    context "with a remux with an mkv container and an hd-dvd source" do
      Given(:release){build_stubbed :movie_release, source: "hd-dvd", container: "mkv", remaster_title: "remux"}
      Then{expect(subject).to be_acceptable}
    end
  end
end
