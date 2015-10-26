require 'spec_helper'

describe ViewObjects::Dashboard do
  subject{described_class.new}

  describe "#movies_waitlist" do
    Given!(:movie_downloadable){create :movie, download_at: Date.yesterday}
    Given!(:movie_waitlist){create :movie, waitlist: true}
    When(:result){subject.movies_waitlist}
    Then{expect(result).to contain_exactly(movie_waitlist)}
  end
end
