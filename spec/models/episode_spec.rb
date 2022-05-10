require "spec_helper"

describe Episode do
  subject{create :episode, releases: [release_hdtv, release_webdl, release_webdl_no_exist, release_webdl_4k]}

  it{is_expected.to belong_to(:tv_show)}
  it{is_expected.to have_many(:releases).class_name("EpisodeRelease")}

  Given(:release_hdtv){create :episode_release, source: "hdtv", resolution: "1080p"}
  Given(:release_webdl){create :episode_release, source: "web-dl", resolution: "1080p"}
  Given(:release_webdl_4k){create :episode_release, source: "web-dl", resolution: "2160p"}
  Given(:release_webdl_no_exist){create :episode_release_missing, source: "web-dl", resolution: "1080p"}

  it_behaves_like "has a valid factory"

  describe "#best_release" do
    When(:result){subject.best_release}
    Then{expect(result).to eq release_webdl_4k}
  end

  describe "#download" do
    When(:result){subject.download}

    context "with no release" do
      Given!(:tv_show){create :tv_show, name: "Extreme Cake Makers", watching: true}
      subject{tv_show.episodes.create name: "Extreme Cake Makers", year: 2018, season_number: 2, episode: 1, watched: false}

      Then{expect(result).to be_nil}
    end

    context "with releases and season completed" do
      Given!(:tv_show){create :tv_show, name: "Extreme Cake Makers", watching: true}
      Given!(:season){create :season, tv_show: tv_show, number: 2}
      subject{tv_show.episodes.create name: "Extreme Cake Makers", year: 2018, season_number: 2, episode: 1, watched: false, season: season}

      Given!(:release){create :episode_release, episode: subject, downloaded: false, resolution: "720p"}
      Given!(:release2){create :episode_release, episode: subject, downloaded: false, resolution: "1080p"}

      Then{expect(result).to eq release2.url}
      And{expect(release2.reload).to be_downloaded}
      And{expect(subject).to be_downloaded}
      And{expect(season.reload).to be_downloaded}
    end

    context "with releases and season not completed" do
      Given!(:tv_show){create :tv_show, name: "Extreme Cake Makers", watching: true}
      Given!(:season){create :season, tv_show: tv_show, number: 2}
      subject{tv_show.episodes.create name: "Extreme Cake Makers", year: 2018, season_number: 2, episode: 1, watched: false, season: season}

      Given{tv_show.episodes.create name: "Extreme Cake Makers", year: 2018, season_number: 2, episode: 2, watched: false, season: season}
      Given!(:release){create :episode_release, episode: subject, downloaded: false, resolution: "720p"}
      Given!(:release2){create :episode_release, episode: subject, downloaded: false, resolution: "1080p"}

      Then{expect(result).to eq release2.url}
      And{expect(release2.reload).to be_downloaded}
      And{expect(subject).to be_downloaded}
      And{expect(season.reload).not_to be_downloaded}
    end
  end

  describe "#update_download_at" do
    Given(:download_at){nil}
    subject{create :episode, download_at: download_at}

    When{subject.update_download_at}

    context "with an episode with no releases" do
      Given(:releases){[]}
      Then{expect(subject.download_at).to be_nil}
    end

    context "with an episode with a killer release and no existing download_at" do
      Given!(:release_killer){create :episode_release, episode: subject, source: "web-dl", resolution: "2160p"}
      Given(:releases){[release_killer]}
      Then{expect(subject.download_at).to be <= DateTime.now}
    end

    context "with an episode with a killer release and existing download_at" do
      Given(:download_at){DateTime.tomorrow}
      Given!(:release_killer){create :episode_release, episode: subject, source: "web-dl", resolution: "2160p"}
      Then{expect(subject.download_at).to be <= DateTime.now}
    end

    context "with an episode with a killer release and existing download_at. Episode is old" do
      subject{create :episode, download_at: download_at}

      Given(:download_at){2.weeks.ago}
      Given!(:release_killer){create :episode_release, episode: subject, source: "web-dl", resolution: "2160p"}
      Then{expect(subject.download_at).to eq download_at}
    end

    context "with an episode without killer release and existing download_at" do
      Given(:download_at){Time.zone.today}
      Given!(:release1){create :episode_release, episode: subject, source: "web-dl", resolution: "720p"}
      Given!(:release2){create :episode_release, episode: subject, source: "hdtv", resolution: "720p"}

      Given(:releases){[release1, release2]}
      Then{expect(subject.download_at).to eq download_at}
    end
  end

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
      Then{expect(subject).not_to be_downloadable}
    end
  end
end
