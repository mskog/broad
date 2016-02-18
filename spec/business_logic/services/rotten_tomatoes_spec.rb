require 'spec_helper'

describe Services::RottenTomatoes, :nodb do

  describe ".matches?" do
    context "with an imdb URL" do
      Given(:data){"http://www.rottentomatoes.com/m/alien/"}
      Then{expect(described_class.matches?(data)).to be_truthy}
    end

    context "with something that doesnt match" do
      Given(:data){"tt1049413"}
      Then{expect(described_class.matches?(data)).to be_falsy}
    end
  end

  describe ".from_data" do
    Given(:result){described_class.from_data(data)}

    context "with a RottenTomatoes URL" do
      Given(:data){"rottentomatoes.com/m/alien"}
      Then{expect(result.query).to eq 'Alien'}
      And{expect(result.url).to eq 'http://www.rottentomatoes.com/m/alien/'}
    end

    context "with a year at the end of the url" do
      Given(:data){"http://www.rottentomatoes.com/m/only_yesterday_1991/"}
      Then{expect(result.query).to eq 'Only Yesterday'}
      And{expect(result.url).to eq data}
    end
    
    context "with something that doesnt match" do
      Given(:data){"9223232"}
      Then{expect{result}.to raise_error(described_class::InvalidDataError)}
    end
  end

  describe ".from_url" do
    Given(:result){described_class.from_data(data)}

    context "with a RottenTomatoes URL" do
      Given(:data){"http://www.rottentomatoes.com/m/alien/"}
      Then{expect(result.query).to eq 'Alien'}
      And{expect(result.url).to eq 'http://www.rottentomatoes.com/m/alien/'}
    end

    context "with a year at the end of the url" do
      Given(:data){"http://www.rottentomatoes.com/m/only_yesterday_1991/"}
      Then{expect(result.query).to eq 'Only Yesterday'}
      And{expect(result.url).to eq data}
    end

    context "with something that doesnt match" do
      Given(:data){"9223232"}
      Then{expect{result}.to raise_error(described_class::InvalidDataError)}
    end
  end
end
