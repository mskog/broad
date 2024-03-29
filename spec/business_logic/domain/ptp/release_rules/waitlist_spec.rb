require "spec_helper"

describe Domain::Ptp::ReleaseRules::Waitlist, :nodb do
  subject{described_class.new(release)}

  describe "#acceptable?" do
    context "with a movie released within the last year" do
      Given(:movie){build_stubbed :movie, release_date: Date.today - 6.months}

      context "with 3d" do
        Given(:release){build_stubbed :movie_release, movie: movie, version_attributes: ["3d"]}
        Then{expect(subject).not_to be_acceptable}
      end

      context "with 3d half sbs" do
        Given(:release){build_stubbed :movie_release, movie: movie, version_attributes: ["3d_half_sbs"]}
        Then{expect(subject).not_to be_acceptable}
      end

      context "with a netflix movie" do
        Given(:release){build_stubbed :movie_release, movie: movie, source: "web", release_name: "Marriage.Story.2019.1080p.NF.WEB-DL.DDP5.1.x264-CMRG.mkv"}
        Then{expect(subject).to be_acceptable}
      end

      context "with an amazon movie" do
        Given(:release){build_stubbed :movie_release, movie: movie, source: "web", release_name: "Onward.2020.1080p.AMZN.WEB-DL.DDP5.1.H.264-PyR8zdl.mkv"}
        Then{expect(subject).to be_acceptable}
      end

      context "with a bluray source" do
        Given(:release){build_stubbed :movie_release, movie: movie, source: "blu-ray"}
        Then{expect(subject).to be_acceptable}
      end

      context "with a non mkv container" do
        Given(:release){build_stubbed :movie_release, movie: movie, container: "m2ts"}
        Then{expect(subject).not_to be_acceptable}
      end

      context "with 720p resolution" do
        Given(:release){build_stubbed :movie_release, movie: movie, source: "blu-ray", resolution: "720p"}
        Then{expect(subject).not_to be_acceptable}
      end
    end

    context "with a movie more than a year ago" do
      Given(:movie){build_stubbed :movie, release_date: Date.today - 18.months}

      context "with 3d" do
        Given(:release){build_stubbed :movie_release, movie: movie, version_attributes: ["3d"]}
        Then{expect(subject).to be_acceptable}
      end

      context "with 3d half sbs" do
        Given(:release){build_stubbed :movie_release, movie: movie, version_attributes: ["3d_half_sbs"]}
        Then{expect(subject).to be_acceptable}
      end

      context "with source not bluray" do
        Given(:release){build_stubbed :movie_release, movie: movie, source: "dvd"}
        Then{expect(subject).to be_acceptable}
      end

      context "with a bluray source" do
        Given(:release){build_stubbed :movie_release, movie: movie, source: "blu-ray"}
        Then{expect(subject).to be_acceptable}
      end

      context "with a non mkv container" do
        Given(:release){build_stubbed :movie_release, movie: movie, container: "m2ts"}
        Then{expect(subject).to be_acceptable}
      end

      context "with a bdrip" do
        Given(:release){build_stubbed :movie_release, movie: movie, source: "blu-ray", release_name: "something.BDrip"}
        Then{expect(subject).to be_acceptable}
      end

      context "with 720p resolution" do
        Given(:release){build_stubbed :movie_release, movie: movie, source: "blu-ray", resolution: "720p"}
        Then{expect(subject).to be_acceptable}
      end
    end
  end
end
