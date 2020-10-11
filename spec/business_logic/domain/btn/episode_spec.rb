require "spec_helper"

describe Domain::BTN::Episode, :nodb do
  Given(:release_hdtv){build_stubbed :episode_release, source: "hdtv", resolution: "1080p"}
  Given(:release_webdl){build_stubbed :episode_release, source: "web-dl", resolution: "1080p"}
  Given(:release_webdl_4k){build_stubbed :episode_release, source: "web-dl", resolution: "2160p"}
  Given(:release_webdl_no_exist){build_stubbed :episode_release_missing, source: "web-dl", resolution: "1080p"}
  Given(:episode){build_stubbed :episode, releases: [release_hdtv, release_webdl, release_webdl_no_exist, release_webdl_4k]}

  subject{described_class.new(episode)}

  describe "#best_release" do
    When(:result){subject.best_release}
    Then{expect(result).to eq release_webdl_4k}
  end

  describe "#best_available_release" do
    When(:result){subject.best_available_release}
    Then{expect(result).to eq release_webdl_4k}
  end

  describe "#download_delay" do
    Given(:episode){build_stubbed :episode, releases: releases}

    When(:result){subject.download_delay}

    context "with no releases" do
      Given(:releases){[]}
      Then{expect(result).to be_nil}
    end

    context "with an episode with a killer wed-dl release" do
      Given(:release_killer){build_stubbed :episode_release, source: "web-dl", resolution: "1080p"}
      Given(:releases){[release_killer]}
      Then{expect(result).to eq 0}
    end

    context "with an episode with a killer wed-dl release in 4k" do
      Given(:release_killer){build_stubbed :episode_release, source: "web-dl", resolution: "2160p"}
      Given(:releases){[release_killer]}
      Then{expect(result).to eq 0}
    end

    context "with an episode with a killer webrip release" do
      Given(:release_killer){build_stubbed :episode_release, source: "webrip", resolution: "1080p"}
      Given(:releases){[release_killer]}
      Then{expect(result).to eq 0}
    end

    context "with an episode with a killer hdtv release" do
      Given(:release_killer){build_stubbed :episode_release, source: "hdtv", resolution: "1080p"}
      Given(:releases){[release_killer]}
      Then{expect(result).to eq 0}
    end

    context "with an episode without killer release" do
      Given(:release_1){build_stubbed :episode_release, source: "web-dl", resolution: "720p"}
      Given(:release_2){build_stubbed :episode_release, source: "hdtv", resolution: "720p "}
      Given(:releases){[release_1, release_2]}
      Then{expect(result).to eq ENV["DELAY_HOURS"].to_i}
    end
  end

  describe "#download_at" do
    Given(:download_at){nil}
    Given(:episode){build_stubbed :episode, releases: releases, download_at: download_at}
    When(:result){subject.download_at}

    context "with an episode with no releases" do
      Given(:releases){[]}
      Then{expect(result).to be_nil}
    end

    context "with an episode with a killer release and no existing download_at" do
      Given(:release_killer){build_stubbed :episode_release, source: "web-dl", resolution: "1080p"}
      Given(:releases){[release_killer]}
      Then{expect(result).to be <= DateTime.now}
    end

    context "with an episode with a killer release and existing download_at" do
      Given(:download_at){DateTime.tomorrow}
      Given(:release_killer){build_stubbed :episode_release, source: "web-dl", resolution: "1080p"}
      Given(:releases){[release_killer]}
      Then{expect(result).to be <= DateTime.now}
    end

    context "with an episode without killer release" do
      Given(:release){build_stubbed :episode_release, source: "web-dl", resolution: "720p"}
      Given(:releases){[release]}
      Then{expect(result).to be >= DateTime.now}
    end

    context "with an episode without killer release and existing download_at" do
      Given(:download_at){Date.today}
      Given(:release_1){build_stubbed :episode_release, source: "web-dl", resolution: "720p"}
      Given(:release_2){build_stubbed :episode_release, source: "hdtv", resolution: "720p"}

      Given(:releases){[release_1, release_2]}
      Then{expect(result).to eq episode.download_at}
    end
  end
end
