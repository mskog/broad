require 'spec_helper'

describe Services::Imdb, :nodb do

  describe "#from_url" do
    Given(:result){described_class.from_url(url)}

    context "with a non-imdb url" do
      Given(:url){"http://www.google.com"}
      Then{expect{result}.to raise_error(described_class::InvalidUrlError)}
    end

    context "with an imdb movie url" do
      Given(:url){"http://www.imdb.com/title/tt1049413/?ref_=rvi_tt"}
      Then{expect(result.id).to eq 'tt1049413'}
      And{expect(result.url).to eq 'http://www.imdb.com/title/tt1049413'}
    end
  end
end
