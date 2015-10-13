require 'spec_helper'

describe Movie do
  it{is_expected.to have_many(:releases).class_name(MovieRelease)}

  describe ".downloadable" do
    Given!(:movie){create :movie, waitlist: false}
    Given!(:movie_waitlist){create :movie, waitlist: true}
    Given!(:movie_waitlist_downloadable){create :movie, waitlist: true, download_at: DateTime.now-1.day}
    When(:result){described_class.downloadable}
    Then{expect(result).to contain_exactly(movie, movie_waitlist_downloadable)}
  end

  describe ".on_waitlist" do
    Given!(:movie){create :movie, waitlist: false}
    Given!(:movie_waitlist){create :movie, waitlist: true}
    Given!(:movie_waitlist_not_downloadable){create :movie, waitlist: true, download_at: DateTime.now-1.day}
    When(:result){described_class.on_waitlist}
    Then{expect(result).to contain_exactly(movie_waitlist)}
  end
end
