require "spec_helper"

describe PtpMovieRecommendations do
  Given(:recommendations) do
    data = JSON.parse(File.read("spec/fixtures/ptp/movie_recommendations.json"))
    data.map do |item|
      Services::PTP::TopMovie.new(item)
    end
  end

  subject{described_class.new(recommendations)}

  describe "Defaults" do
    When(:result){subject}
    Then{expect(result.count).to eq 10}
    And{expect(result.map(&:title)).to include("Nomadland")}
  end

  describe "#with_minimum_rating" do
    context "with default minimum rating" do
      When(:result){subject.with_minimum_rating}
      Then{expect(result.count).to eq 3}
      And{expect(result).to(be_all{|item| item.ptp_rating > described_class::MINIMUM_RATING})}
    end

    context "with specified minimum rating" do
      When(:result){subject.with_minimum_rating(75)}
      Then{expect(result.count).to eq 1}
      And{expect(result).to(be_all{|item| item.ptp_rating >= 75})}
    end
  end

  describe "#not_downloaded" do
    context "with no movies downloaded" do
      When(:result){subject.not_downloaded}
      Then{expect(result.count).to eq 10}
    end

    context "with some movies downloaded" do
      Given!(:movie){create :movie, title: "Nomadland", imdb_id: "tt9770150"}

      When(:result){subject.not_downloaded}
      Then{expect(result.count).to eq 9}
      And{expect(result.map(&:title)).not_to(include(movie.title))}
    end
  end

  describe "#since_year" do
    When(:result){subject.since_year(2020)}
    Then{expect(result.count).to eq 7}
    And{expect(result).to(be_all{|item| item.year.to_i >= 2020})}
  end

  describe "With a combination" do
    Given!(:movie){create :movie, title: "Nomadland", imdb_id: "tt9770150"}

    When(:result){subject.not_downloaded.with_minimum_rating}
    Then{expect(result.count).to eq 2}
  end
end
