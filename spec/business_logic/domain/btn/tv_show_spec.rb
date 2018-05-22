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

  context "with a show with episodes" do
    pending
  end

  context "with a show with no sample episode or not found at all" do
    pending
  end
end