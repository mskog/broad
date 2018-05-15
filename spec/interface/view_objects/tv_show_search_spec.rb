require 'spec_helper'

describe ViewObjects::TvShowSearch do
  subject{described_class.new(query)}

  context "with a text query" do
    Given(:query){'better call saul'}
    Given(:first_movie){subject.first}
    Then{expect(subject.count).to eq 3}
    And{expect(first_movie.title).to eq 'Better Call Saul'}
    And{expect(first_movie.year).to eq 2015}
    And{expect(first_movie.overview).to start_with('We meet him')}
    And{expect(first_movie.imdb_id).to eq('tt3032476')}
    And{expect(first_movie.imdb_url).to eq('http://www.imdb.com/title/tt3032476/')}
  end
end
