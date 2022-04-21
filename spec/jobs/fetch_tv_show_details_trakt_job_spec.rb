require "spec_helper"

describe FetchTvShowDetailsTraktJob do
  subject{described_class.new}

  Given!(:credential){create :credential, name: "trakt"}

  When{subject.perform(tv_show)}

  context "with an existing show" do
    Given(:tv_show){create :tv_show, name: "Better Call Saul", imdb_id: "tt3032476"}
    Given(:first_episode){tv_show.episodes.first}
    Then{expect(tv_show.trakt_details["year"]).to eq 2015}
    And{expect(tv_show.imdb_id).to eq "tt3032476"}
    And{expect(tv_show.tvdb_id).to eq 273_181}
    And{expect(tv_show.status).to eq "returning series"}
    And{expect(tv_show.episodes.count).to eq 12}
    # And{expect(first_episode.name).to eq "Uno"}
    # And{expect(first_episode.season_number).to eq 1}
    # And{expect(first_episode.episode).to eq 1}
    # And{expect(first_episode.season.number).to eq 1}
  end

  context "with an existing show with some existing episodes" do
    Given(:tv_show){create :tv_show, name: "Better Call Saul", imdb_id: "tt3032476"}
    Given(:season){create :season, number: 1, tv_show: tv_show}
    Given(:season2){create :season, number: 20, tv_show: tv_show}
    Given{create :episode, tv_show: tv_show, season_number: 1, episode: 1, season: season}
    Given{create :episode, tv_show: tv_show, season_number: 20, episode: 400, season: season2}
    Given(:first_episode){tv_show.episodes.first}
    Given(:last_episode){tv_show.episodes.last}
    Then{expect(tv_show.trakt_details["year"]).to eq 2015}
    And{expect(tv_show.tvdb_id).to eq 273_181}
    And{expect(tv_show.episodes.count).to eq 13}
    And{expect(first_episode).to be_downloaded}
    And{expect(first_episode).to be_watched}
    And{expect(last_episode).not_to be_downloaded}
    And{expect(last_episode).not_to be_watched}
    And{expect(tv_show.seasons.first).to be_downloaded}
    And{expect(tv_show.seasons.first).to be_watched}
    And{expect(tv_show.seasons.last).not_to be_downloaded}
    And{expect(tv_show.seasons.last).not_to be_watched}
  end
end
