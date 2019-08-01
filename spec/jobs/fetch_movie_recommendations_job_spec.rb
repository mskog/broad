require "spec_helper"

describe FetchMovieRecommendationsJob do
  subject{described_class.new}

  Given!(:credential){create :credential, name: "trakt"}

  When{subject.perform}

  context "with no recommendations in the database" do
    Given(:first_recommendation){MovieRecommendation.first}
    Then{expect(MovieRecommendation.count).to eq 10}
    And{expect(first_recommendation.title).to eq "Strange Days"}
    And{expect(first_recommendation.year).to eq 1995}
    And{expect(first_recommendation.imdb_id).to eq "tt0114558"}
    And{expect(first_recommendation.trakt_id).to eq "237"}
    And{expect(first_recommendation.tmdb_id).to eq "281"}
    And{expect(first_recommendation.trakt_slug).to eq "strange-days-1995"}
  end

  context "with matching recommendations in the database already" do
    Given{create :movie_recommendation, imdb_id: "tt0114558"}
    Then{expect(MovieRecommendation.count).to eq 10}
  end
end
