require 'spec_helper'

describe ViewObjects::MovieSearch do
  subject{described_class.new(query)}

  context "with a text query" do
    Given(:query){'alien'}
    Given(:first_movie){subject.first}
    Then{expect(subject.count).to eq 9}
    And{expect(subject.map(&:poster).all?(&:present?)).to be_truthy}
    And{expect(first_movie.title).to eq 'Alien'}
    And{expect(first_movie.year).to eq 1979}
    And{expect(first_movie.overview).to start_with('During its return')}
    And{expect(first_movie.imdb_id).to eq('tt0078748')}
    And{expect(first_movie.imdb_url).to eq('http://www.imdb.com/title/tt0078748/')}
    And{expect(first_movie.poster).to eq('https://walter.trakt.us/images/movies/000/000/295/posters/thumb/b943584d95.jpg')}
  end
end
