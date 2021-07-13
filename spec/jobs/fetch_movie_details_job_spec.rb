require "spec_helper"

describe FetchMovieDetailsJob do
  describe "#perform" do
    When{described_class.perform_now movie}

    context "with a Movie" do
      Given(:movie){create :movie, imdb_id: "tt1160419"}
      Then{expect(movie.title).to eq "Dune"}
      And{expect(movie.imdb_id).to eq "tt1160419"}
      And{expect(movie.tmdb_id).to eq "438631"}
      And{expect(movie.trakt_id).to eq "287071"}
      And{expect(movie.trakt_rating).to eq 7.77419}
      And{expect(movie.trakt_slug).to eq "dune-2021"}
      And{expect(movie.release_date).to eq Date.parse("2021-10-01")}
      And{expect(movie.runtime).to eq 90}
      And{expect(movie.language).to eq "en"}
      And{expect(movie.genres).to eq %w[science-fiction adventure drama]}
      And{expect(movie.overview).to start_with "Paul"}

      And{expect(movie.available_date).to eq Date.parse("2021-08-22")}
    end

    context "with a Movie with no results. Do not overwrite existing data" do
      Given(:movie){create :movie, imdb_id: "hello", title: "Terminator"}
      Then{expect(movie.title).to eq "Terminator"}
      And{expect(movie.tmdb_id).to be_nil}
    end
  end
end
