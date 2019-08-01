require "spec_helper"

describe EpisodeReleaseDecorator, :nodb do
  subject{described_class.new(episode_release)}
  Given(:episode_release){build_stubbed :episode_release}

  describe "#joined_attributes" do
    When(:result){subject.joined_attributes}
    Then{expect(result).to eq "HDTV - 1080p"}
  end
end
