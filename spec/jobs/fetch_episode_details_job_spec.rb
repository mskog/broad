require "spec_helper"

describe FetchEpisodeDetailsJob do
  subject{described_class.new}

  When{subject.perform(episode)}

  context "with an existing episode" do
    Given{expect(described_class).not_to receive(:set).with(wait: 3.hours)}
    Given(:tv_show){create :tv_show, name: "Hannibal", tmdb_details: {"id" => "1621"}}
    Given(:episode){create :episode, tv_show: tv_show, season_number: 2, episode: 3}
    Then{expect(episode.tmdb_details["name"]).to eq "A Dangerous Maid"}
    And{expect(episode.air_date).to eq Date.parse("2011-10-09")}
  end

  context "with a missing episode" do
    Given(:mock){double}
    Given{expect(described_class).to receive(:set).with(wait: 3.hours){mock}}
    Given{expect(mock).to receive(:perform_later).with(episode)}

    Given(:tv_show){create :tv_show, name: "Hannibal", tmdb_details: {"id" => "404"}}
    Given(:episode){create :episode, tv_show: tv_show, season_number: 2, episode: 3}

    Then{expect(episode.tmdb_details).not_to be_present}
    And{expect(episode.air_date).to be_nil}
  end

  context "with an episode that after fetching has no still_path" do
    Given(:mock){double}
    Given{expect(described_class).to receive(:set).with(wait: 3.hours){mock}}
    Given{expect(mock).to receive(:perform_later).with(episode)}

    Given(:tv_show){create :tv_show, name: "Hannibal", tmdb_details: {"id" => "404"}}
    Given(:episode){create :episode, tv_show: tv_show, season_number: 2, episode: 3, tmdb_details: {"still_path" => nil}}
    Then {}
  end

  context "with an episode that after fetching has no overview" do
    Given(:mock){double}
    Given{expect(described_class).to receive(:set).with(wait: 3.hours){mock}}
    Given{expect(mock).to receive(:perform_later).with(episode)}

    Given(:tv_show){create :tv_show, name: "Hannibal", tmdb_details: {"id" => "404"}}
    Given(:episode){create :episode, tv_show: tv_show, season_number: 2, episode: 3, tmdb_details: {"still_path" => "sdfsdf", overview: "sdfsdfs"}}
    Then {}
  end

  context "with an episode that after fetching has no still_path, but it is too old to try again with" do
    Given{expect(described_class).not_to receive(:set).with(wait: 3.hours){mock}}

    Given(:tv_show){create :tv_show, name: "Hannibal", tmdb_details: {"id" => "404"}}
    Given(:episode){create :episode, tv_show: tv_show, season_number: 2, episode: 3, created_at: Date.today - 8, tmdb_details: {"still_path" => nil}}
    Then {}
  end
end
