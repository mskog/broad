require 'spec_helper'

describe Services::Search do
  context "Movies" do
    subject{described_class.movies(query)}

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

    context "with a metacritic url" do
      Given(:query){"http://www.metacritic.com/movie/Alien"}
      Given(:first_movie){subject.first}
      Then{expect(subject.count).to eq 10}
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

  context "TV Shows" do
    subject{described_class.tv_shows(query)}

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
end
