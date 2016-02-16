require 'spec_helper'

describe Services::Imdb, :nodb do

  describe ".matches?" do
    context "with an imdb ID" do
      Given(:data){'tt1049413'}
      Then{expect(described_class.matches?(data)).to be_truthy}
    end

    context "with an imdb URL" do
      Given(:data){"http://www.imdb.com/title/tt1049413/?ref_=rvi_tt"}
      Then{expect(described_class.matches?(data)).to be_truthy}
    end

    context "with something that doesnt match" do
      Given(:data){"9223232"}
      Then{expect(described_class.matches?(data)).to be_falsy}
    end

  end

  describe ".from_data" do
    Given(:result){described_class.from_data(data)}

    context "with an imdb ID" do
      Given(:data){'tt1049413'}
      Then{expect(result.id).to eq data}
    end

    context "with an imdb URL" do
      Given(:data){"http://www.imdb.com/title/tt1049413/?ref_=rvi_tt"}
      Then{expect(result.id).to eq 'tt1049413'}
    end

    context "with something that doesnt match" do
      Given(:data){"9223232"}
      Then{expect{result}.to raise_error(described_class::InvalidDataError)}
    end
  end

  describe "#from_url" do
    Given(:result){described_class.from_url(url)}

    context "with a non-imdb url" do
      Given(:url){"http://www.google.com"}
      Then{expect{result}.to raise_error(described_class::InvalidUrlError)}
    end

    context "with an imdb movie url" do
      Given(:url){"http://www.imdb.com/title/tt1049413/?ref_=rvi_tt"}
      Then{expect(result.id).to eq 'tt1049413'}
      And{expect(result.url).to eq 'http://www.imdb.com/title/tt1049413/'}
    end
  end
end
