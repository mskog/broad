require 'spec_helper'

describe FetchMovieDetailsJob do
  subject{described_class.new}

  describe "#perform" do
    When{subject.perform(movie)}

    context "with a movie that is found" do
      Given(:movie){create :movie, title: nil}
      Then{expect(movie.omdb_details["actors"]).to eq "Dong-gun Jang, Bin Won, Eun-ju Lee, Hyeong-jin Kong"}
      And{expect(movie.title).to eq 'Tae Guk Gi: The Brotherhood of War'}
    end
  end
end
