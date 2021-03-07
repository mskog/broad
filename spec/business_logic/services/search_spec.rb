require "spec_helper"

describe Services::Search do
  describe "#movies" do
    When(:result){subject.movies(query)}

    context "with results" do
      Given(:first_result){result.first}
      Given(:query){"Terminator"}
      Then{expect(result.count).to eq 10}
      And{expect(first_result.title).to eq "Terminator 2: Judgment Day"}
    end
  end
end
