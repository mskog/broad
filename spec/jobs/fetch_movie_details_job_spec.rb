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

    context "with a movie that is not found" do
      Given(:movie){create :movie, title: nil, imdb_id: 'tt4354930'}
      Then{expect(movie.omdb_details).to_not be_present}
    end

    context "with a movie recommendation that is found" do
      Given(:movie){create :movie_recommendation}
      Then{expect(movie.omdb_details["actors"]).to eq "Dong-gun Jang, Bin Won, Eun-ju Lee, Hyeong-jin Kong"}
      And{expect(movie.title).to eq 'Tae Guk Gi: The Brotherhood of War'}
    end

    context "with a movie that is not found" do
      Given(:movie){create :movie_recommendation, imdb_id: 'tt4354930'}
      Then{expect(movie.omdb_details).to_not be_present}
    end

  end
end
