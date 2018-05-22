require 'spec_helper'

describe Services::TvShowSearch do
  subject{described_class.new(query)}

  context "with a text query" do
    Given(:query){'better call saul'}
    Given(:first_show){subject.first}
    Then{expect(subject.count).to eq 3}
    And{expect(first_show.title).to eq 'Better Call Saul'}
    And{expect(first_show.year).to eq 2015}
    And{expect(first_show.overview).to start_with('We meet him')}
    And{expect(first_show.imdb_id).to eq('tt3032476')}
    And{expect(first_show.tmdb_id).to eq('60059')}
    And{expect(first_show.tvdb_id).to eq('273181')}
    And{expect(first_show.imdb_url).to eq('http://www.imdb.com/title/tt3032476/')}
    And{expect(first_show.downloaded).to be_falsy}
  end

  context "with an imdb id" do
    Given(:query){'tt3032476'}
    Given(:first_show){subject.first}
    Then{expect(subject.count).to eq 3}
    And{expect(first_show.title).to eq 'Better Call Saul'}
    And{expect(first_show.downloaded).to be_falsy}
  end

  context "with an imdb url" do
    Given(:query){"http://www.imdb.com/title/#{imdb_id}/?ref_=fn_al_tt_1"}
    Given(:imdb_id){'tt3032476'}
    Given(:first_show){subject.first}
    Then{expect(subject.count).to eq 3}
    And{expect(first_show.title).to eq 'Better Call Saul'}
    And{expect(first_show.downloaded).to be_falsy}
  end

  context "with a metacritic url" do
    Given(:query){"http://www.metacritic.com/tv/better-call-saul"}
    Given(:first_show){subject.first}
    Then{expect(subject.count).to eq 3}
    And{expect(first_show.title).to eq 'Better Call Saul'}
    And{expect(first_show.downloaded).to be_falsy}
  end

  context "with a rotten tomatoes url" do
    Given(:name){'better_call_saul'}
    Given(:query){"http://www.rottentomatoes.com/tv/#{name}"}

    Given(:first_show){subject.first}
    Then{expect(first_show.title).to eq 'Better Call Saul'}
    And{expect(first_show.downloaded).to be_falsy}
  end

  context "with an existing show" do
    Given!(:movie){create :movie, imdb_id: 'tt3032476'}
    Given(:query){'tt3032476'}
    Given(:first_show){subject.first}
    Then{expect(subject.count).to eq 3}
    And{expect(first_show.title).to eq 'Better Call Saul'}
    And{expect(first_show.downloaded).to be_truthy}
  end
end
