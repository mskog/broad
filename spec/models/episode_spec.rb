require 'spec_helper'

describe Episode do
  it{is_expected.to belong_to(:tv_show)}
  it{is_expected.to have_many(:releases).class_name("EpisodeRelease")}

  it_behaves_like 'has a valid factory'

  describe ".downloadable" do
    Given(:episode_downloadable){create :episode, download_at: Date.yesterday}
    Given(:episode_not_downloadable){create :episode, download_at: Date.tomorrow}
    Then{expect(described_class.downloadable).to contain_exactly(episode_downloadable)}
  end

  describe "#downloadable?" do
    subject{episode}

    context "with a downloadable episode" do
      Given(:episode){build_stubbed :episode, download_at: 10.hours.ago}
      Then{expect(subject).to be_downloadable}
    end

    context "with an episode which is still waiting for its time" do
      Given(:episode){build_stubbed :episode, download_at: Date.tomorrow}
      Then{expect(subject).to_not be_downloadable}
    end
  end
end
