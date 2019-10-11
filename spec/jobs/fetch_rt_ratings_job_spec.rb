require "spec_helper"

describe FetchRtRatingsJob do
  describe "#perform" do
    When{described_class.perform_now movie}

    Given(:movie){create :movie, title: "Alien"}
    Then{expect(movie.rt_critics_rating).to be_between(1, 100)}
    And{expect(movie.rt_audience_rating).to be_between(1, 100)}
  end
end
