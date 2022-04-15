require "spec_helper"

describe TvShow do
  it{is_expected.to have_many(:episodes)}

  it_behaves_like "has a valid factory"

  describe "#sample" do
    When(:result){subject.sample}

    context "with a show with episodes" do
      subject{create :tv_show, tvdb_id: 273_181}

      Given(:expected_episode){subject.episodes.first}

      Then{expect(subject.episodes.count).to eq 1}
      And{expect(subject.episodes.all{|episode| episode.season == 1}).to be_truthy}
      And{expect(subject.episodes.all{|episode| episode.episode == 1}).to be_truthy}
      And{expect(expected_episode.releases.size).to eq 8}
      And{expect(subject.waitlist).to be_falsy}
    end

    context "with a show with episodes, but only a full season" do
      subject{create :tv_show, tvdb_id: 12_345, imdb_id: "tt0944947"}

      Given(:expected_episode){subject.episodes.first}

      Then{expect(subject.episodes.count).to eq 10}
      And{expect(subject.episodes.all{|episode| episode.season == 1}).to be_truthy}
      And{expect(subject.episodes.all{|episode| episode.episode == 1}).to be_truthy}
      And{expect(subject.episodes.all{|episode| episode.download_at.present?}).to be_truthy}
      And{expect(expected_episode.releases.size).to eq 1}
      And{expect(subject.waitlist).to be_falsy}
    end

    context "with a show with episodes, on waitlist" do
      subject{create :tv_show, tvdb_id: 273_181, waitlist: true}

      Given(:expected_episode){subject.episodes.first}

      Then{expect(subject.episodes.count).to eq 1}
      And{expect(subject.episodes.all{|episode| episode.season == 1}).to be_truthy}
      And{expect(subject.episodes.all{|episode| episode.episode == 1}).to be_truthy}
      And{expect(expected_episode.releases.size).to eq 8}
      And{expect(subject.waitlist).to be_falsy}
    end

    context "with a show with 'sample' already downloaded" do
      subject{create :tv_show, tvdb_id: 273_181, episodes: [create(:episode, name: "The Strain", season: 1, episode: 1)]}

      Then{expect(subject.episodes.count).to eq 1}
      And{expect(subject.waitlist).to be_falsy}
    end

    context "with a show without episodes" do
      subject{create :tv_show, tvdb_id: 11_111}

      Then{expect(subject.episodes.count).to eq 0}
      And{expect(subject.waitlist).to be_truthy}
    end
  end

  describe "#collect" do
    context "with no existing episodes" do
      subject{create :tv_show, tvdb_id: 273_181, imdb_id: "tt0944947"}

      Given{expect(subject).to receive(:download_season).with(1)}
      Given{expect(subject).to receive(:download_season).with(2)}

      When(:result){subject.collect}
      Then {}
    end
  end

  describe "#download_season" do
    When(:result){subject.download_season(season_number)}

    context "with a season that has a full season release" do
      Given(:season_number){1}
      subject{create :tv_show, tvdb_id: 273_181, imdb_id: "tt0944947"}

      Then{expect(subject.episodes.count).to eq 10}
      And{expect(subject.episodes.last.name).to eq "Fire and Blood"}
    end

    context "with a season that does not have a full season release" do
      Given(:season_number){1}
      subject{create :tv_show, tvdb_id: 341_455, imdb_id: "tt0944947"}

      Then{expect(subject.episodes.count).to eq 2}
      And{expect(subject.episodes.last.name).to eq "Marvel's Cloak & Dagger"}
    end
  end

  describe "watch" do
    subject{create :tv_show, watching: false}

    When(:result){subject.watch}
    Then{expect(subject.watching).to be_truthy}
    And{expect(subject.reload.watching).to be_truthy}
  end

  describe "unwatch" do
    subject{create :tv_show, watching: true}

    When(:result){subject.unwatch}
    Then{expect(subject.watching).to be_falsy}
    And{expect(subject.reload.watching).to be_falsy}
  end
end
