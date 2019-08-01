require "spec_helper"

describe Services::Trakt::Shows do
  subject{described_class.new}

  describe "#summary" do
    context "simple query" do
      Given(:id){"tt2654620"}

      When(:result){subject.summary(id)}

      Then{expect(result.title).to eq "The Strain"}
      And{expect(result.year).to eq 2014}
      And{expect(result.ids.slug).to eq "the-strain"}
      And{expect(result.ids.trakt).to eq 47_350}
      And{expect(result.ids.tmdb).to eq 47_640}
      And{expect(result.ids.imdb).to eq "tt2654620"}
      And{expect(result.overview).to start_with "A mysterious"}
      And{expect(result.first_aired).to eq Date.parse("2014-07-14")}
      And{expect(result.runtime).to eq 39}
      And{expect(result.trailer).to eq "http://youtube.com/watch?v=_42rx8Dm6OQ"}
      And{expect(result.homepage).to eq "http://www.fxnetworks.com/thestrain"}
      And{expect(result.rating).to eq 7.42252}
      And{expect(result.votes).to eq 5337}
      And{expect(result.updated_at).to eq DateTime.parse("Thu, 03 May 2018 11:06:28.000000000 +0000")}
      And{expect(result.language).to eq "en"}
      And{expect(result.genres).to eq %w[drama mystery science-fiction]}
      And{expect(result.certification).to eq "TV-MA"}
      And{expect(result.country).to eq "us"}
      And{expect(result.network).to eq "FX (US)"}
      And{expect(result.status).to eq "ended"}
      And{expect(result.aired_episodes).to eq 46}
    end

    context "simple query. Nothing found" do
      Given(:id){"tt0078748"}

      When(:result){subject.summary(id)}

      Then{expect(result.title).to be_nil}
      And{expect(result.ids.trakt).to be_nil}
    end
  end

  describe "#episodes" do
    When(:result){subject.episodes(id)}
    Given(:id){"tt0944947"}

    context "with default arguments (does not include the special seasons)" do
      Given(:first_result){result.first}
      Given(:last_result){result.last}
      Then{expect(result.count).to eq 20}
      And{expect(first_result.season).to eq 1}
      And{expect(first_result.number).to eq 1}
      And{expect(first_result.title).to eq "Winter Is Coming"}
      And{expect(first_result.ids.imdb).to eq "tt1480055"}
      And{expect(last_result.season).to eq 2}
      And{expect(last_result.number).to eq 10}
      And{expect(last_result.title).to eq "Valar Morghulis"}
      And{expect(last_result.ids.imdb).to eq "tt2112510"}
    end
  end
end
