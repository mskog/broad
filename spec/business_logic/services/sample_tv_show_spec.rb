require 'spec_helper'

describe Services::SampleTvShow do
  subject{described_class.new(imdb_id)}

  When{subject.perform}

  context "with no existing show in the database" do
    Given(:imdb_id){"tt2654620"}

    Given(:expected_tv_show){TvShow.last}
    Given(:expected_episode){expected_tv_show.episodes.first}

    Then{expect(expected_tv_show.name).to eq 'Better Call Saul'}
    And{expect(expected_tv_show.episodes.count).to eq 1}
    And{expect(expected_tv_show.episodes.all{|episode| episode.season == 1}).to be_truthy}
    And{expect(expected_tv_show.episodes.all{|episode| episode.episode == 1}).to be_truthy}
    And{expect(expected_episode.releases.size).to eq 4}
  end

  context "with a show that exists in the database" do
    pending
  end

  context "with a show with no sample episode or not found at all" do
    pending
  end
end