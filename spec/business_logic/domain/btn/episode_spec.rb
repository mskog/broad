require 'spec_helper'

describe Domain::BTN::Episode, :nodb do
  Given(:release_hdtv){build_stubbed :episode_release, source: 'hdtv'}
  Given(:release_webdl){build_stubbed :episode_release, source: 'web-dl'}
  Given(:episode){build_stubbed :episode, releases: [release_hdtv, release_webdl]}
  subject{described_class.new(episode)}

  describe "#best_release" do
    When(:result){subject.best_release}
    Then{expect(result).to eq release_webdl}
  end
end
