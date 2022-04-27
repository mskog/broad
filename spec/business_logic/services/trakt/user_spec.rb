require "spec_helper"

describe Services::Trakt::User do
  Given(:token){"some_token"}

  subject{described_class.new(token: token)}

  describe "#ratings_movies" do
    Given(:first_result){result.first}
    When(:result){subject.ratings_movies}
    Then{expect(result.size).to eq 2}

    And{expect(first_result.movie.ids.trakt).to eq 264_898}
    And{expect(first_result.movie.title).to eq "The Florida Project"}
    And{expect(first_result.rated_at).to eq DateTime.parse("Sat, 24 Feb 2018 23:28:15.000000000 +0000")}
  end

  describe "#history_shows" do
    Given(:first_result){result.first}
    When(:result){subject.history_shows}
    Then{expect(result.size).to eq 10}

    And{expect(first_result.episode.ids.trakt).to eq 2_313_353}
    And{expect(first_result.show.ids.trakt).to eq 1394}
    And{expect(first_result.show.title).to eq "Marvel's Agents of S.H.I.E.L.D."}
  end

  describe "#history_movies" do
    Given(:first_result){result.first}
    When(:result){subject.history_movies}
    Then{expect(result.size).to eq 10}

    And{expect(first_result.movie.ids.trakt).to eq 137_261}
    And{expect(first_result.movie.title).to eq "Sausage Party"}
    And{expect(first_result.watched_at).to eq "Sat, 05 Nov 2016 22:59:08 +0000"}
  end

  describe "#collected_show" do
    Given(:first_season){result.seasons.first}
    Given(:second_season){result.seasons.second}
    Given(:id){"tt3032476"}
    When(:result){subject.collected_show(id)}

    Then{expect(result).not_to be_completed}
    And{expect(first_season).to be_completed}
    And{expect(second_season).not_to be_completed}

    And{expect(first_season.episodes.first).to be_completed}
    And{expect(first_season.episodes.first.number).to eq 1}
  end

  describe "#watched_show" do
    Given(:first_season){result.seasons.first}
    Given(:second_season){result.seasons.second}
    Given(:id){"tt3032476"}
    When(:result){subject.watched_show(id)}

    Then{expect(result).to be_completed}
    And{expect(first_season).to be_completed}
    And{expect(second_season).to be_completed}

    And{expect(first_season.episodes.first).to be_completed}
    And{expect(first_season.episodes.first.number).to eq 1}
  end
end
