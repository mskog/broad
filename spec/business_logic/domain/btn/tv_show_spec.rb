require "spec_helper"

describe Domain::BTN::TvShow do
  subject{described_class.new(tv_show)}

  describe "#sample" do
    When(:result){subject.sample}

    context "with a show with episodes" do
      Given(:tv_show){create :tv_show, tvdb_id: 273_181}

      Given(:expected_episode){tv_show.episodes.first}

      Then{expect(result).to eq subject}
      And{expect(tv_show.episodes.count).to eq 1}
      And{expect(tv_show.episodes.all{|episode| episode.season == 1}).to be_truthy}
      And{expect(tv_show.episodes.all{|episode| episode.episode == 1}).to be_truthy}
      And{expect(expected_episode.releases.size).to eq 8}
      And{expect(expected_episode.season.number).to eq 1}
      And{expect(expected_episode.season.tv_show).to eq tv_show}
      And{expect(tv_show.waitlist).to be_falsy}
    end

    context "with a show with episodes, but only a full season" do
      Given(:tv_show){create :tv_show, tvdb_id: 12_345, imdb_id: "tt0944947"}

      Given(:expected_episode){tv_show.episodes.first}

      Then{expect(result).to eq subject}
      And{expect(tv_show.episodes.count).to eq 10}
      And{expect(tv_show.episodes.all{|episode| episode.season == 1}).to be_truthy}
      And{expect(tv_show.episodes.all{|episode| episode.episode == 1}).to be_truthy}
      And{expect(tv_show.episodes.all{|episode| episode.download_at.present?}).to be_truthy}
      And{expect(expected_episode.season.number).to eq 1}
      And{expect(expected_episode.season.tv_show).to eq tv_show}
      And{expect(expected_episode.releases.size).to eq 1}
      And{expect(tv_show.waitlist).to be_falsy}
    end

    context "with a show with episodes, on waitlist" do
      Given(:tv_show){create :tv_show, tvdb_id: 273_181, waitlist: true}

      Given(:expected_episode){tv_show.episodes.first}

      Then{expect(result).to eq subject}
      And{expect(tv_show.episodes.count).to eq 1}
      And{expect(tv_show.episodes.all{|episode| episode.season == 1}).to be_truthy}
      And{expect(tv_show.episodes.all{|episode| episode.episode == 1}).to be_truthy}
      And{expect(expected_episode.releases.size).to eq 8}
      And{expect(expected_episode.season.number).to eq 1}
      And{expect(expected_episode.season.tv_show).to eq tv_show}
      And{expect(tv_show.waitlist).to be_falsy}
    end

    context "with a show with 'sample' already downloaded" do
      Given(:tv_show){create :tv_show, tvdb_id: 273_181, episodes: [create(:episode, name: "The Strain", season_number: 1, episode: 1)]}

      Then{expect(result).to eq subject}
      And{expect(tv_show.episodes.count).to eq 1}
      And{expect(tv_show.waitlist).to be_falsy}
    end

    context "with a show without episodes" do
      Given(:tv_show){create :tv_show, tvdb_id: 11_111}

      Then{expect(result).to eq subject}
      And{expect(tv_show.episodes.count).to eq 0}
      And{expect(tv_show.waitlist).to be_truthy}
    end
  end

  describe "#collect" do
    context "with no existing episodes" do
      Given(:tv_show){create :tv_show, tvdb_id: 273_181, imdb_id: "tt0944947"}
      Given{expect(subject).to receive(:download_season).with(1)}
      Given{expect(subject).to receive(:download_season).with(2)}

      When(:result){subject.collect}
      Then{expect(result).to eq subject}
    end
  end

  describe "#download_season" do
    When(:result){subject.download_season(season_number)}

    context "with a season that has a full season release" do
      Given(:season_number){1}
      Given(:tv_show){create :tv_show, tvdb_id: 273_181, imdb_id: "tt0944947"}
      Then{expect(result).to eq subject}
      And{expect(tv_show.seasons.count).to eq 1}
      And{expect(tv_show.seasons.first.number).to eq 1}
      And{expect(tv_show.episodes.map(&:season)).to all(eq tv_show.seasons.first)}
      And{expect(tv_show.episodes.count).to eq 10}
      And{expect(tv_show.episodes.last.name).to eq "Fire and Blood"}
    end

    context "with a season that does not have a full season release" do
      Given(:season_number){1}
      Given(:tv_show){create :tv_show, tvdb_id: 341_455, imdb_id: "tt0944947"}

      Then{expect(result).to eq subject}
      And{expect(tv_show.episodes.count).to eq 2}
      And{expect(tv_show.episodes.last.name).to eq "Marvel's Cloak & Dagger"}
      And{expect(tv_show.seasons.count).to eq 1}
      And{expect(tv_show.seasons.first.number).to eq 1}
      And{expect(tv_show.episodes.map(&:season)).to all(eq tv_show.seasons.first)}
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
