require 'spec_helper'

describe FetchEpisodeDetailsJob do
  subject{described_class.new}

  When{subject.perform(episode)}

  context "with an existing episode" do
    Given{expect(described_class).to_not receive(:set).with(wait: 1.hour)}
    Given(:tv_show){create :tv_show, name: 'Hannibal', tmdb_details: {'id' => "1621"}}
    Given(:episode){create :episode, tv_show: tv_show, season: 2, episode: 3}
    Then{expect(episode.tmdb_details['name']).to eq 'A Dangerous Maid'}
  end

  context "with a missing episode" do
    Given(:mock){double}
    Given{expect(described_class).to receive(:set).with(wait: 1.hour){mock}}
    Given{expect(mock).to receive(:perform_later).with(episode)}

    Given(:tv_show){create :tv_show, name: 'Hannibal', tmdb_details: {'id' => "404"}}
    Given(:episode){create :episode, tv_show: tv_show, season: 2, episode: 3}

    Then{expect(episode.tmdb_details).to_not be_present}
  end

  context "with an episode that after fetching has no still_path" do
    Given(:mock){double}
    Given{expect(described_class).to receive(:set).with(wait: 1.hour){mock}}
    Given{expect(mock).to receive(:perform_later).with(episode)}

    Given(:tv_show){create :tv_show, name: 'Hannibal', tmdb_details: {'id' => "404"}}
    Given(:episode){create :episode, tv_show: tv_show, season: 2, episode: 3, tmdb_details: {'still_path' => nil}}
    Then{}
  end

  context "with an episode that after fetching has no overview" do
    Given(:mock){double}
    Given{expect(described_class).to receive(:set).with(wait: 1.hour){mock}}
    Given{expect(mock).to receive(:perform_later).with(episode)}

    Given(:tv_show){create :tv_show, name: 'Hannibal', tmdb_details: {'id' => "404"}}
    Given(:episode){create :episode, tv_show: tv_show, season: 2, episode: 3, tmdb_details: {'still_path' => "sdfsdf", overview: 'sdfsdfs'}}
    Then{}
  end

  context "with an episode that after fetching has no still_path, but it is too old to try again with" do
    Given{expect(described_class).to_not receive(:set).with(wait: 1.hour){mock}}

    Given(:tv_show){create :tv_show, name: 'Hannibal', tmdb_details: {'id' => "404"}}
    Given(:episode){create :episode, tv_show: tv_show, season: 2, episode: 3, created_at: Date.today-8, tmdb_details: {'still_path' => nil}}
    Then{}
  end
end
