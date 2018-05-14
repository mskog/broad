require 'spec_helper'

describe Services::Metacritic, :nodb do

  describe ".matches?" do
    context "with a Metacritic movie URL" do
      Given(:data){"http://www.metacritic.com/movie/tully-2018"}
      Then{expect(described_class.matches?(data)).to be_truthy}
    end

    context "with a Metacritic URL with extra stuff at the end" do
      Given(:data){"http://www.metacritic.com/movie/tully-2018?ref=hp"}
      Then{expect(described_class.matches?(data)).to be_truthy}
    end

    context "with a Metacritic tv show URL" do
      Given(:data){"http://www.metacritic.com/tv/better_call_saul"}
      Then{expect(described_class.matches?(data)).to be_truthy}
    end

    context "with something that doesnt match" do
      Given(:data){"tt1049413"}
      Then{expect(described_class.matches?(data)).to be_falsy}
    end
  end

  describe ".from_data" do
    Given(:result){described_class.from_data(data)}

    context "with a Metacritic URL" do
      Given(:data){"metacritic.com/movie/alien"}
      Then{expect(result.query).to eq 'Alien'}
      And{expect(result.url).to eq 'http://www.metacritic.com/movie/alien/'}
    end

    context "with extra stuff at the end" do
      Given(:data){"http://www.metacritic.com/movie/tully-2018?ref=hp"}
      Then{expect(result.query).to eq 'Tully 2018'}
      And{expect(result.url).to eq "http://www.metacritic.com/movie/tully-2018/"}
    end

    context "with a Metacritic tv show URL" do
      Given(:data){"http://www.metacritic.com/tv/better_call_saul"}
      Then{expect(result.query).to eq 'Better Call Saul'}
      And{expect(result.url).to eq "http://www.metacritic.com/tv/better_call_saul/"}
    end

    context "with something that doesnt match" do
      Given(:data){"9223232"}
      Then{expect{result}.to raise_error(described_class::InvalidDataError)}
    end
  end

  describe ".from_url" do
    Given(:result){described_class.from_data(data)}

    context "with a Metacritic URL" do
      Given(:data){"metacritic.com/movie/alien"}
      Then{expect(result.query).to eq 'Alien'}
      And{expect(result.url).to eq 'http://www.metacritic.com/movie/alien/'}
    end

    context "with extra stuff at the end" do
      Given(:data){"http://www.metacritic.com/movie/tully-2018?ref=hp"}
      Then{expect(result.query).to eq 'Tully 2018'}
      And{expect(result.url).to eq "http://www.metacritic.com/movie/tully-2018/"}
    end

    context "with a Metacritic tv show URL" do
      Given(:data){"http://www.metacritic.com/tv/better_call_saul"}
      Then{expect(result.query).to eq 'Better Call Saul'}
      And{expect(result.url).to eq "http://www.metacritic.com/tv/better_call_saul/"}
    end

    context "with something that doesnt match" do
      Given(:data){"9223232"}
      Then{expect{result}.to raise_error(described_class::InvalidDataError)}
    end
  end
end
