require "spec_helper"

describe Services::Trakt::Movies do
  subject{described_class.new}

  describe "#summary" do
    context "with a simple query" do
      Given(:id){"tt0078748"}

      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/movies/#{id}?extended=full")
          .to_return(body: File.new("spec/fixtures/trakt/movies/summary/#{id}.json"))
      end

      When(:result){subject.summary(id)}

      Then{expect(result.title).to eq "Alien"}
      And{expect(result.ids.trakt).to eq 295}
      And{expect(result.ids.slug).to eq "alien-1979"}
      And{expect(result.ids.tmdb).to eq 348}
      And{expect(result.ids.imdb).to eq "tt0078748"}
      And{expect(result.tagline).to eq "In space no one can hear you scream."}
      And{expect(result.overview).to start_with "During its return"}
      And{expect(result.released).to eq Date.parse("1979-06-21")}
      And{expect(result.runtime).to eq 117}
      And{expect(result.trailer).to eq "http://youtube.com/watch?v=097uj1HjkbM"}
      And{expect(result.homepage).to eq "https://www.facebook.com/alienanthology/"}
      And{expect(result.rating).to eq 8.46944}
      And{expect(result.votes).to eq 11_861}
      And{expect(result.updated_at).to eq DateTime.parse("2017-06-02T09:11:23.000Z")}
      And{expect(result.language).to eq "en"}
      And{expect(result.genres).to eq %w[action horror science-fiction thriller]}
      And{expect(result.certification).to eq "R"}
    end

    context "with a simple query. Nothing found" do
      Given(:id){"tt0078748"}

      Given do
        stub_request(:get, "https://api-v2launch.trakt.tv/movies/#{id}?extended=full")
          .to_return(status: 404)
      end

      When(:result){subject.summary(id)}

      Then{expect(result.title).to be_nil}
      And{expect(result.ids.trakt).to be_nil}
    end
  end

  describe "#release_date" do
    Given(:imdb_id){"tt1160419"}

    context "with no release_type" do
      When(:result){subject.release_date(imdb_id)}
      Then{expect(result).to eq Date.parse("2021-08-22")}
    end

    context "with set release_type" do
      When(:result){subject.release_date(imdb_id, "digital")}
      Then{expect(result).to eq Date.parse("2021-09-01")}
    end

    context "with no movie found" do
      When(:result){subject.release_date("foobar")}
      Then{expect(result).to be_nil}
    end

    context "with empty results" do
      When(:result){subject.release_date("empty")}
      Then{expect(result).to be_nil}
    end

    context "with empty results for given release type" do
      When(:result){subject.release_date(imdb_id, "test")}
      Then{expect(result).to be_nil}
    end
  end
end
