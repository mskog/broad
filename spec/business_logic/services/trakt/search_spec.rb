require 'spec_helper'

describe Services::Trakt::Search do
  subject{described_class.new}

  describe '#movies' do
    context "simple query" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/search?query=deadpool&type=movie").to_return(body: JSON.parse(File.new('spec/fixtures/trakt/search/movies_deadpool.json').read))
      end

      Given(:query){'deadpool'}
      When(:result){subject.movies(query)}
      Then{expect(result.first['movie']['title']).to eq 'Deadpool'}
    end

    context "with year" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/search?query=deadpool&type=movie&year=#{year}").to_return(body: JSON.parse(File.new('spec/fixtures/trakt/search/movies_deadpool.json').read))
      end

      Given(:query){'deadpool'}
      Given(:year){2015}
      When(:result){subject.movies(query, year: year)}
      Then{expect(result.first['movie']['title']).to eq 'Deadpool'}
    end
  end

  describe "#shows" do
    context "simple query" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/search?query=Better%20Call%20Saul&type=show").to_return(body: JSON.parse(File.new('spec/fixtures/trakt/search/shows_better_call_saul.json').read))
      end

      Given(:query){'Better Call Saul'}
      When(:result){subject.shows(query)}
      Then{expect(result.first['show']['title']).to eq 'Better Call Saul'}
      And{expect(result.first['show']['year']).to eq 2015}
    end

    context "with year" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/search?query=Better%20Call%20Saul&type=show&year=2015").to_return(body: JSON.parse(File.new('spec/fixtures/trakt/search/shows_better_call_saul.json').read))
      end

      Given(:query){'Better Call Saul'}
      Given(:year){2015}
      When(:result){subject.shows(query, year: year)}
      Then{expect(result.first['show']['title']).to eq 'Better Call Saul'}
    end
  end

  describe "#id" do
    context "by imdb id" do
      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/search?id=#{id}&id_type=imdb").to_return(body: JSON.parse(File.new('spec/fixtures/trakt/search/movies_deadpool.json').read))
      end

      Given(:id){'tt1431045'}
      Given(:id_type){'imdb'}
      When(:result){subject.id(id, id_type: id_type)}
      Then{expect(result.first['movie']['title']).to eq 'Deadpool'}
    end
  end
end
