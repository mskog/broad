require "spec_helper"

describe DateHelper, type: :helper do
  describe "#human_date" do
    When(:result){human_date(date)}

    context "with Today's date" do
      Given(:date){Date.today}
      Then{expect(result).to eq "Today"}
    end

    context "with Yesterday's date" do
      Given(:date){Date.yesterday}
      Then{expect(result).to eq "Yesterday"}
    end

    context "with some other date" do
      Given(:date){Date.parse("2015-10-01")}
      Then{expect(result).to eq date}
    end
  end
end
