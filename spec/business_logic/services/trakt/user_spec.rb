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
  end
end
