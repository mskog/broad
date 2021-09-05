require "spec_helper"

describe FetchTvShowDetailsTraktJob do
  subject{described_class.new}

  When{subject.perform(tv_show)}

  context "with an existing show" do
    Given(:tv_show){create :tv_show, name: "Better Call Saul"}
    Given(:first_episode){tv_show.episodes.first}
    Then{expect(tv_show.trakt_details[:year]).to eq 2015}
    And{expect(tv_show.imdb_id).to eq "tt3032476"}
    And{expect(tv_show.tvdb_id).to eq 273_181}
    And{expect(tv_show.status).to eq "returning series"}
    And{expect(tv_show.episodes.count).to eq 12}
    And{expect(first_episode.name).to eq "Uno"}
    And{expect(first_episode.season).to eq 1}
    And{expect(first_episode.episode).to eq 1}
  end

  context "with an existing show with imdb collision" do
    Given(:tv_show){create :tv_show, name: "Better Call Saul"}
    Given{create :tv_show, name: "Collision", imdb_id: "tt3032476"}
    Given(:first_episode){tv_show.episodes.first}
    Then{expect(tv_show.trakt_details[:year]).to be_nil}
    And{expect(tv_show.imdb_id).to be_nil}
  end

  context "with an existing show with some existing episodes" do
    Given(:tv_show){create :tv_show, name: "Better Call Saul"}
    Given{create :episode, tv_show: tv_show, season: 1, episode: 1}
    Given(:first_episode){tv_show.episodes.first}
    Then{expect(tv_show.trakt_details[:year]).to eq 2015}
    And{expect(tv_show.imdb_id).to eq "tt3032476"}
    And{expect(tv_show.tvdb_id).to eq 273_181}
    And{expect(tv_show.episodes.count).to eq 12}
  end

  context "with a missing show" do
    Given(:tv_show){create :tv_show, name: "nofound"}
    Then{expect(tv_show.trakt_details).not_to be_present}
  end

  context "with a show whose top result has no imdb id" do
    Given(:tv_show){create :tv_show, name: "the terror"}
    Then{expect(tv_show.imdb_id).not_to be_present}
    And{expect(tv_show.trakt_details).not_to be_present}
  end
end
