require 'spec_helper'

describe Services::Trakt::User do
  Given(:token){'some_token'}

  subject{described_class.new(token: token)}

  describe "#history_shows" do
    Given(:first_result){result.first}
    When(:result){subject.history_shows}
    Then{expect(result.size).to eq 10}

    And{expect(first_result.episode.ids.trakt).to eq 2313353}
    And{expect(first_result.show.ids.trakt).to eq 1394}
    And{expect(first_result.show.title).to eq "Marvel's Agents of S.H.I.E.L.D."}
  end

  describe "#history_movies" do
    Given(:first_result){result.first}
    When(:result){subject.history_movies}
    Then{expect(result.size).to eq 10}

    And{expect(first_result.movie.ids.trakt).to eq 137261}
    And{expect(first_result.movie.title).to eq "Sausage Party"}
    And{expect(first_result.watched_at).to eq "Sat, 05 Nov 2016 22:59:08 +0000"}
  end
end
