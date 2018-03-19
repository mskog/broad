require 'spec_helper'

describe Services::MovieSearch do
  subject{described_class.new(query)}

  context "with a text query" do
    Given(:query){'alien'}
    Given(:first_movie){subject.first}
    Then{expect(subject.count).to eq 10}
    And{expect(first_movie.title).to eq 'Alien'}
    And{expect(first_movie.year).to eq 1979}
    And{expect(first_movie.overview).to start_with('During its return')}
    And{expect(first_movie.imdb_id).to eq('tt0078748')}
    And{expect(first_movie.tmdb_id).to eq('348')}
    And{expect(first_movie.imdb_url).to eq('http://www.imdb.com/title/tt0078748/')}
    And{expect(first_movie.downloaded).to be_falsy}
  end

  context "with an imdb id" do
    Given(:query){'tt0078748'}
    Given(:first_movie){subject.first}
    Then{expect(subject.count).to eq 1}
    And{expect(first_movie.title).to eq 'Alien'}
    And{expect(first_movie.downloaded).to be_falsy}
  end

  context "with an imdb url" do
    Given(:query){"http://www.imdb.com/title/#{imdb_id}/?ref_=fn_al_tt_1"}
    Given(:imdb_id){'tt0078748'}
    Given(:first_movie){subject.first}
    Then{expect(subject.count).to eq 1}
    And{expect(first_movie.title).to eq 'Alien'}
    And{expect(first_movie.downloaded).to be_falsy}
  end

  context "with a rotten tomatoes url" do
    Given(:name){'alien'}
    Given(:query){"http://www.rottentomatoes.com/m/#{name}/"}

    Given(:first_movie){subject.first}
    Then{expect(first_movie.title).to eq 'Alien'}
    And{expect(first_movie.downloaded).to be_falsy}
  end

  context "with an existing movie" do
    Given!(:movie){create :movie, imdb_id: 'tt0078748'}
    Given(:query){'tt0078748'}
    Given(:first_movie){subject.first}
    Then{expect(subject.count).to eq 1}
    And{expect(first_movie.title).to eq 'Alien'}
    And{expect(first_movie.downloaded).to be_truthy}
  end
end
