require 'spec_helper'

describe Movie do
  it{is_expected.to have_many(:releases).class_name(MovieRelease)}

  describe ".downloadable" do
    Given!(:movie_no_download_at){create :movie, waitlist: false}
    Given!(:movie_earlier_download_at){create :movie, waitlist: false, download_at: Date.yesterday}
    Given!(:movie_later_download_at){create :movie, waitlist: false, download_at: Date.tomorrow}
    Given!(:movie_waitlist){create :movie, waitlist: true}
    Given!(:movie_waitlist_downloadable){create :movie, waitlist: true, download_at: DateTime.now-1.day}
    When(:result){described_class.downloadable}
    Then{expect(result).to contain_exactly(movie_no_download_at, movie_earlier_download_at, movie_waitlist_downloadable)}
  end

  describe ".on_waitlist" do
    Given!(:movie){create :movie, waitlist: false}
    Given!(:movie_waitlist){create :movie, waitlist: true}
    Given!(:movie_waitlist_not_downloadable){create :movie, waitlist: true, download_at: DateTime.now-1.day}
    When(:result){described_class.on_waitlist}
    Then{expect(result).to contain_exactly(movie_waitlist)}
  end

  describe "#deletable?", :nodb do
    subject{movie}

    context "with a movie on waitlist but no download_at" do
      Given(:movie){build_stubbed(:movie, waitlist: true)}
      Then{expect(subject).to be_deletable}
    end

    context "with a movie on waitlist, with download_at but it is later than now" do
      Given(:movie){build_stubbed(:movie, waitlist: true, download_at: Date.tomorrow)}
      Then{expect(subject).to be_deletable}
    end

    context "with a movie on waitlist, with download_at earlier than now" do
      Given(:movie){build_stubbed(:movie, waitlist: true, download_at: Date.yesterday)}
      Then{expect(subject).to_not be_deletable}
    end

    context "with a movie not on the waitlist and with download_at later than now" do
      Given(:movie){build_stubbed(:movie, waitlist: false, download_at: Date.tomorrow)}
      Then{expect(subject).to_not be_deletable}
    end

    context "with a movie not on the waitlist and with download_at earlier than now" do
      Given(:movie){build_stubbed(:movie, waitlist: false, download_at: DateTime.now)}
      Then{expect(subject).to_not be_deletable}
    end
  end
end
