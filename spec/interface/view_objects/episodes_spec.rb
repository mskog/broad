require "spec_helper"

describe ViewObjects::Episodes do
  subject{described_class.new(episodes)}

  describe ".from_params" do
    Given!(:episodes){[create(:episode), create(:episode)]}
    When(:result){described_class.from_params(nil)}
    Then{expect(result.first).to eq episodes.last}
    And{expect(result.first).to respond_to(:best_release)}
  end

  describe "Enumeration", :nodb do
    Given(:episodes){[build_stubbed(:episode), build_stubbed(:episode)]}
    When(:result){subject.to_a}
    Then{expect(result).to eq episodes}
    And{expect(subject.first).to eq episodes.first}
    And{expect(result.first).to respond_to(:best_release)}
  end

  describe "#with_release" do
    Given!(:episode_with_release){create :episode, releases: [create(:episode_release)]}
    Given!(:episode_without_release){create :episode}
    Given(:episodes){Episode.all}
    When(:result){subject.with_release}
    Then{expect(result.map(&:id)).to contain_exactly(episode_with_release.id)}
  end

  describe "#with_distinct_releases" do
    Given(:episode){create :episode}
    Given!(:episode_release){create :episode_release, episode: episode}
    Given!(:other_episode){create :episode}
    Given!(:other_episode_release){create :episode_release, episode: other_episode, url: episode_release.url}
    Given(:episodes){Episode.all}
    When(:result){subject.with_distinct_releases}
    Then{expect(result.count).to eq 1}
  end

  describe "downloadable" do
    When(:result){subject.downloadable.to_a}

    context "with downloadable and non-downloadable episodes" do
      Given!(:downloadable_episode){create :episode, download_at: Date.today - 2}
      Given!(:other_episode){create :episode, download_at: Date.tomorrow}
      Given(:episodes){Episode.all}
      Then{expect(result).to eq [downloadable_episode]}
      And{expect(result.first).to respond_to(:best_release)}
    end
  end
end
