require 'spec_helper'

describe Domain::BTN::TvShow do
  subject{described_class.new(tv_show)}

  describe "#sample" do
    When{subject.sample}

    context "with a show without episodes" do
      Given(:tv_show){create :tv_show, tvdb_id: 273181}

      Given(:expected_episode){tv_show.episodes.first}

      Then{expect(tv_show.episodes.count).to eq 1}
      And{expect(tv_show.episodes.all{|episode| episode.season == 1}).to be_truthy}
      And{expect(tv_show.episodes.all{|episode| episode.episode == 1}).to be_truthy}
      And{expect(expected_episode.releases.size).to eq 8}
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

  describe "#download_season" do
    When{subject.download_season(season_number)}

    context "with a season that has a full season release" do
      Given(:season_number){1}
      Given(:tv_show){create :tv_show, tvdb_id: 273181}
      Given(:first_episode){tv_show.episodes.first}
      Given(:last_episode){tv_show.episodes.first}
      Given do
        10.times do |n|
          create :episode, tv_show: tv_show, season: 1, episode: n+1
        end
      end
      Given!(:watched_episode){create :episode, tv_show: tv_show, season: 1, episode: 11, watched: true}
      Then{expect(first_episode.releases.count).to eq 10}
      And{expect(last_episode.releases.count).to eq 10}
      And{expect(watched_episode.releases.count).to eq 0}
    end

    context "with a season that has a full season release but with no unwatched episodes" do
      Given(:season_number){1}
      Given(:tv_show){create :tv_show, tvdb_id: 273181}
      Given(:first_episode){tv_show.episodes.first}
      Given(:last_episode){tv_show.episodes.first}
      Given do
        10.times do |n|
          create :episode, tv_show: tv_show, season: 1, episode: n+1, watched: true
        end
      end
      Then{expect(first_episode.releases.count).to eq 0}
      And{expect(last_episode.releases.count).to eq 0}
    end

    context "with a season that has a full season release but with no episodes without releases" do
      Given(:season_number){1}
      Given(:tv_show){create :tv_show, tvdb_id: 273181}
      Given(:first_episode){tv_show.episodes.first}
      Given(:last_episode){tv_show.episodes.first}
      Given do
        10.times do |n|
          create :episode, tv_show: tv_show, season: 1, episode: n+1, releases: [create(:episode_release)]
        end
      end
      Then{expect(first_episode.releases.count).to eq 1}
      And{expect(last_episode.releases.count).to eq 1}
    end

    context "with a season that does not have a full season release" do
      Given(:season_number){1}
      Given(:tv_show){create :tv_show, tvdb_id: 341455}
      Given(:first_episode){tv_show.episodes.first}
      Given(:second_episode){tv_show.episodes.second}
      Given(:third_episode){tv_show.episodes.third}
      Given do
        10.times do |n|
          create :episode, tv_show: tv_show, season: 1, episode: n+1, watched: n+1 == 2
        end
      end

      Then{expect(first_episode.releases.count).to eq 6}
      And{expect(second_episode.releases.count).to eq 0}
      And{expect(third_episode.releases.count).to eq 0}
    end

    context "with a season that has nothing" do
      Given(:season_number){2}
      Given(:tv_show){create :tv_show, tvdb_id: 341455}
      Given(:first_episode){tv_show.episodes.first}
      Given(:second_episode){tv_show.episodes.second}
      Given(:third_episode){tv_show.episodes.third}
      Given do
        10.times do |n|
          create :episode, tv_show: tv_show, season: 1, episode: n+1
        end
      end

      Then{expect(first_episode.releases.count).to eq 0}
      And{expect(second_episode.releases.count).to eq 0}
      And{expect(third_episode.releases.count).to eq 0}
    end
  end

  describe "watch" do
    Given(:tv_show){create :tv_show, watching: false}
    When(:result){subject.watch}
    Then{expect(result).to eq subject}
    And{expect(tv_show.watching).to be_truthy}
    And{expect(tv_show.reload.watching).to be_truthy}
  end

  describe "unwatch" do
    Given(:tv_show){create :tv_show, watching: true}
    When(:result){subject.unwatch}
    Then{expect(result).to eq subject}
    And{expect(tv_show.watching).to be_falsy}
    And{expect(tv_show.reload.watching).to be_falsy}
  end
end
