require 'spec_helper'

describe FetchMovieDetailsJob do
  describe "#perform" do
    When{described_class.perform_now movie}

    context "with a Movie" do
      Given(:movie){create :movie, imdb_id: "tt0078748"}
      Then{expect(movie.title).to eq "Alien"}
      And{expect(movie.imdb_id).to eq "tt0078748"}
      And{expect(movie.tmdb_id).to eq "348"}
      And{expect(movie.trakt_id).to eq "295"}
      And{expect(movie.trakt_rating).to eq 8.46944}
      And{expect(movie.trakt_slug).to eq "alien-1979"}
      And{expect(movie.release_date).to eq Date.parse("1979-06-21")}
      And{expect(movie.runtime).to eq 117}
      And{expect(movie.language).to eq "en"}
      And{expect(movie.genres).to eq ["action", "horror", "science-fiction", "thriller"]}
      And{expect(movie.overview).to start_with "During"}
    end

    context "with a MovieRecommendation" do
      Given(:movie){create :movie_recommendation, imdb_id: "tt0078748"}
      Then{expect(movie.title).to eq "Alien"}
      And{expect(movie.imdb_id).to eq "tt0078748"}
      And{expect(movie.tmdb_id).to eq "348"}
      And{expect(movie.trakt_id).to eq "295"}
      And{expect(movie.trakt_rating).to eq 8.46944}
      And{expect(movie.trakt_slug).to eq "alien-1979"}
      And{expect(movie.release_date).to eq Date.parse("1979-06-21")}
      And{expect(movie.runtime).to eq 117}
      And{expect(movie.language).to eq "en"}
      And{expect(movie.genres).to eq ["action", "horror", "science-fiction", "thriller"]}
      And{expect(movie.overview).to start_with "During"}
    end

  end
end
