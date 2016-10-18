require 'spec_helper'

describe Services::Trakt::Recommendations do
  Given(:token){'some_token'}

  subject{described_class.new(token: token)}

  describe "#movies" do
    context "with defaults" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/recommendations/movies")
          .with(headers: {'Authorization' => "Bearer #{token}"})
          .to_return(body: JSON.parse(File.new('spec/fixtures/trakt/recommendations/movies.json').read))
      end

      Given(:first_result){result.first}
      When(:result){subject.movies}
      Then{expect(result.size).to eq 10}

      And{expect(first_result.ids.imdb).to eq 'tt0114558'}
      And{expect(first_result.ids.tmdb).to eq 281}
      And{expect(first_result.ids.trakt).to eq 237}
      And{expect(first_result.title).to eq "Strange Days"}
      And{expect(first_result.year).to eq 1995}
    end
  end
end
