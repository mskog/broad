require 'spec_helper'

describe FetchMovieDetailsJob do
  subject{described_class.new}

  describe "#perform" do
    When{subject.perform(movie)}

    context "with a movie that is found" do
      Given(:movie){create :movie}
      Then{expect(movie.omdb_details["actors"]).to eq "Dong-gun Jang, Bin Won, Eun-ju Lee, Hyeong-jin Kong"}
    end
  end
end
