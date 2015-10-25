require 'spec_helper'

describe Episode do
  it{is_expected.to belong_to(:tv_show)}
  it{is_expected.to have_many(:releases).class_name("EpisodeRelease")}

  describe "#downloadable?" do
    subject{episode}

    context "with a downloadable episode" do
      Given(:episode){build_stubbed :episode, published_at: 10.hours.ago}
      Then{expect(subject).to be_downloadable}
    end

    context "with an episode which is still waiting for its time" do
      Given(:episode){build_stubbed :episode, published_at: 1.hour.ago}
      Then{expect(subject).to_not be_downloadable}
    end
  end

  describe "#downloading_at" do
    subject{episode}

    When(:result){subject.downloading_at}

    Given(:episode){build_stubbed :episode, published_at: 10.hours.ago}
    Then{expect(result).to eq episode.published_at + ENV['DELAY_HOURS'].to_i.hours}
  end
end
