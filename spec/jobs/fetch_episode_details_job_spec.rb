require 'spec_helper'

describe FetchEpisodeDetailsJob do
  subject{described_class.new}

  When{subject.perform(episode)}

  context "with an existing episode" do
    Given(:tv_show){create :tv_show, name: 'Hannibal', tmdb_details: {'id' => "1621"}}
    Given(:episode){create :episode, tv_show: tv_show, season: 2, episode: 3}
    Then{expect(episode.tmdb_details['name']).to eq 'A Dangerous Maid'}
  end

  context "with a missing episode" do
    Given(:tv_show){create :tv_show, name: 'Hannibal', tmdb_details: {'id' => "404"}}
    Given(:episode){create :episode, tv_show: tv_show, season: 2, episode: 3}

    Then{expect(episode.tmdb_details).to_not be_present}
  end
end
