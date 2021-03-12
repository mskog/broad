require "spec_helper"

describe Services::Search do
  describe "#imdb_id" do
    context "with a found movie" do
    end

    context "with a not found movie" do
    end

    context "with a found tv show" do
    end

    context "with a not found tv show" do
    end
  end

  describe "#movies" do
    When(:result){subject.movies(query)}

    context "with results" do
      Given(:first_result){result.first}
      Given(:query){"Terminator"}
      Then{expect(result.count).to eq 10}
      And{expect(first_result.title).to eq "Terminator 2: Judgment Day"}
    end

    context "with no results" do
      Given(:first_result){result.first}
      Given(:query){"None"}
      Then{expect(result.count).to eq 0}
    end
  end

  describe "#tv_shows" do
    When(:result){subject.tv_shows(query)}

    context "with results" do
      Given(:first_result){result.first}
      Given(:query){"Better Call Saul"}
      Then{expect(result.count).to eq 4}
      And{expect(first_result.title).to eq "Better Call Saul"}
    end

    context "with no results" do
      Given(:first_result){result.first}
      Given(:query){"None"}
      Then{expect(result.count).to eq 0}
    end
  end
end
