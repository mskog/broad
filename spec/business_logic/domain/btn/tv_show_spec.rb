require 'spec_helper'

describe Domain::BTN::TvShow do
  subject{described_class.new(tv_show)}

  When{subject.sample}

  context "with a show without episodes" do
    Given(:tv_show){create :tv_show, tvdb_id: 273181}

    Given(:expected_episode){tv_show.episodes.first}

    Then{expect(tv_show.episodes.count).to eq 1}
    And{expect(tv_show.episodes.all{|episode| episode.season == 1}).to be_truthy}
    And{expect(tv_show.episodes.all{|episode| episode.episode == 1}).to be_truthy}
    And{expect(expected_episode.releases.size).to eq 4}
  end

  context "with a show with 'sample' already downloaded" do
    Given(:tv_show){create :tv_show, tvdb_id: 273181, episodes: [create(:episode, name: "The Strain", season: 1, episode: 1)]}

    Then{expect(tv_show.episodes.count).to eq 1}
  end

  context "with a show without episodes" do
    Given(:tv_show){create :tv_show, tvdb_id: 12345}

    Then{expect(tv_show.episodes.count).to eq 0}
  end
end