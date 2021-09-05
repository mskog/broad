require "spec_helper"

describe Services::MovieDetails do
  describe ".from_trakt" do
    subject{described_class.from_trakt(movie_extended)}

    context "with results" do
      Given(:data){JSON.parse(File.new("spec/fixtures/trakt/movies/summary/tt0078748.json").read)}
      Given(:movie_extended){Services::Trakt::Data::MovieExtended.new(data)}

      Given(:expected_attributes) do
        {
          title: "Alien",
          imdb_id: "tt0078748",
          tmdb_id: 348,
          trakt_id: 295,
          trakt_rating: 8.46944,
          trakt_slug: "alien-1979",
          release_date: Date.parse("1979-06-21"),
          runtime: 117,
          language: "en",
          genres: %w[action horror science-fiction thriller],
          certification: "R",
          overview: "During its return to the earth, commercial spaceship Nostromo intercepts a distress signal from a distant planet. When a three-member team of the crew discovers a chamber containing thousands of eggs on the planet, a creature inside one of the eggs attacks an explorer. The entire crew is unaware of the impending nightmare set to descend upon them when the alien parasite planted inside its unfortunate host is birthed."
        }
      end

      Then{expect(subject.has_data?).to be_truthy}
      And{expect(subject.imdb_id).to eq "tt0078748"}
      And{expect(subject.title).to eq "Alien"}
      And{expect(subject.tmdb_id).to eq 348}
      And{expect(subject.trakt_id).to eq 295}
      And{expect(subject.trakt_rating).to eq 8.46944}
      And{expect(subject.trakt_slug).to eq "alien-1979"}
      And{expect(subject.release_date).to eq Date.parse("1979-06-21")}
      And{expect(subject.runtime).to eq 117}
      And{expect(subject.language).to eq "en"}
      And{expect(subject.genres).to eq %w[action horror science-fiction thriller]}
      And{expect(subject.certification).to eq "R"}
      And{expect(subject.overview).to eq "During its return to the earth, commercial spaceship Nostromo intercepts a distress signal from a distant planet. When a three-member team of the crew discovers a chamber containing thousands of eggs on the planet, a creature inside one of the eggs attacks an explorer. The entire crew is unaware of the impending nightmare set to descend upon them when the alien parasite planted inside its unfortunate host is birthed."}

      And{expect(subject.to_h).to include expected_attributes}
    end
  end
end
