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

    context "with a url with extras" do
      Given(:data){"http://www.rottentomatoes.com/m/the_witch_2016/"}
      Then{expect(result.query).to eq 'The Witch 2016'}
      And{expect(result.url).to eq 'http://www.rottentomatoes.com/m/the_witch_2016/'}
    end

    context "with something that doesnt match" do
      Given(:data){"9223232"}
      Then{expect{result}.to raise_error(described_class::InvalidDataError)}
    end
  end
end
