require "spec_helper"

describe ViewObjects::Search do
  context "Movies" do
    subject{described_class.movies(query)}

    context "with a text query" do
      Given(:query){"alien"}
      Given(:first_movie){subject.first}
      Then{expect(subject.count).to eq 10}
      And{expect(first_movie.title).to eq "Alien"}
      And{expect(first_movie.year).to eq 1979}
      And{expect(first_movie.overview).to start_with("During its return")}
      And{expect(first_movie.imdb_id).to eq("tt0078748")}
      And{expect(first_movie.imdb_url).to eq("http://www.imdb.com/title/tt0078748/")}
    end
  end

  context "TV Shows" do
    subject{described_class.tv_shows(query)}

    context "with a text query" do
      Given(:query){"better call saul"}
      Given(:first_movie){subject.first}
      Then{expect(subject.count).to eq 3}
      And{expect(first_movie.title).to eq "Better Call Saul"}
      And{expect(first_movie.year).to eq 2015}
      And{expect(first_movie.overview).to start_with("We meet him")}
      And{expect(first_movie.imdb_id).to eq("tt3032476")}
      And{expect(first_movie.imdb_url).to eq("http://www.imdb.com/title/tt3032476/")}
    end
  end
end
