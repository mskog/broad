require "spec_helper"

describe Services::SyncWatchedEpisodesWithTrakt do
  Given!(:credential){create :credential, name: "trakt"}

  subject{described_class.new}

  describe "#perform" do
    Given!(:tv_show){create :tv_show, imdb_id: "tt2364582"}
    Given!(:episode){create :episode, tv_show: tv_show, season: 4, episode: 6}
    Given!(:episode_2){create :episode, tv_show: tv_show, season: 5, episode: 6}

    Given!(:other_episode){create :episode}

    When{subject.perform}

    context "with results(brotherhood of war)" do
      Then{expect(episode.reload.watched?).to be_truthy}
      And{expect(episode.reload.watched_at).to be_present}
      And{expect(episode_2.reload.watched?).to be_falsy}
      And{expect(episode_2.reload.watched_at).to_not be_present}
      And{expect(other_episode.reload.watched?).to be_falsy}
      And{expect(other_episode.reload.watched_at).to_not be_present}
    end
  end
end
