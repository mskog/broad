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

  describe "#download_delay" do
    Given(:episode){build_stubbed :episode, releases: releases}

    When(:result){subject.download_delay}

    context "with no releases" do
      Given(:releases){[]}
      Then{expect(result).to be_nil}
    end

    context "with an episode with a killer release" do
      Given(:release_killer){build_stubbed :episode_release, source: 'web-dl', resolution: '1080p'}
      Given(:releases){[release_killer]}
      Then{expect(result).to eq 0}
    end

    context "with an episode with a killer release (webrip)" do
      Given(:release_killer){build_stubbed :episode_release, source: 'webrip', resolution: '1080p'}
      Given(:releases){[release_killer]}
      Then{expect(result).to eq 0}
    end

    context "with an episode without killer release" do
      Given(:release_1){build_stubbed :episode_release, source: 'web-dl', resolution: '720p'}
      Given(:release_2){build_stubbed :episode_release, source: 'hdtv', resolution: '1080p'}
      Given(:releases){[release_1, release_2]}
      Then{expect(result).to eq ENV['DELAY_HOURS'].to_i}
    end
  end
end
