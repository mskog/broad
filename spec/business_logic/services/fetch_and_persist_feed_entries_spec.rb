require "spec_helper"

describe Services::FetchAndPersistFeedEntries do
  Given(:url){"http://www.example.com/foobar.rss"}
  Given(:fixture){File.read("spec/fixtures/btn_feed_episodes.xml")}
  Given{stub_request(:get, url).to_return(body: fixture)}

  Given(:published_since){"2015-07-19 11:08:00 +0000"}
  subject{described_class.new(url, published_since)}

  Given do
    stub_request(:head, /torrents.php/).to_return(File.new("spec/fixtures/btn/existing_torrent.txt"))
  end

  When{subject.perform}

  context "when running once" do
    Given!(:watching_show){create :tv_show, watching: true, name: "Escape to the Country"}
    Given!(:not_watching_show){create :tv_show, watching: false, name: "Extreme Cake Makers"}
    Given(:watching_show_episode){watching_show.episodes.last}
    Given(:watching_show_release){watching_show_episode.releases.last}
    Then{expect(watching_show.episodes.first.download_at).to be <= DateTime.now + 24.hours}
    And{expect(Episode.count).to eq 1}
    And{expect(watching_show.episodes.count).to eq 1}
    And{expect(EpisodeRelease.count).to eq 1}
    And{expect(watching_show_episode.releases.count).to eq 1}
    And{expect(watching_show_episode.season).to eq 18}
    And{expect(watching_show_episode.episode).to eq 53}
    And{expect(watching_show_episode.year).to eq 2018}
    And{expect(watching_show_episode.published_at).to eq "2018-06-05 17:11:00.000000000 +0000"}

    And{expect(watching_show_release.title).to eq "Escape to the Country - S18E53 [ 2018 ] [ MKV | H.264 | WEB-DL | 720p | FastTorrent | Internal ] [ Uploader: Raptor ]  [ Escape.to.the.Country.S18E53.720p.iP.WEB-DL.AAC2.0.H.264-BTW ]"}
    And{expect(watching_show_release.url).to eq "www.example.com"}
    And{expect(watching_show_release.file_type).to eq "mkv"}
    And{expect(watching_show_release.file_encoding).to eq "h.264"}
    And{expect(watching_show_release.source).to eq "web-dl"}
    And{expect(watching_show_release.resolution).to eq "720p"}
    And{expect(watching_show_release.published_at).to eq "2018-06-05 17:11:00.000000000 +0000"}
  end

  context "when running twice" do
    Given!(:watching_show){create :tv_show, watching: true, name: "Escape to the Country"}

    When{subject.perform}

    Then{expect(TvShow.count).to eq 1}
    And{expect(Episode.count).to eq 1}
    And{expect(EpisodeRelease.count).to eq 1}
  end

  context "when adding a killer release to an existing episode" do
    Given(:download_at){Date.tomorrow + 1.day}
    Given!(:watching_show){create :tv_show, watching: true, name: "Extreme Cake Makers"}
    Given!(:episode){watching_show.episodes.create name: "Extreme Cake Makers", year: 2018, season: 2, episode: 1, download_at: download_at}
    Then{expect(episode.reload.download_at).to be < download_at}
  end

  context "when adding a killer release to an existing episode which has already been downloaded but not watched" do
    Given(:download_at){Date.today - 3.days}
    Given!(:tv_show){create :tv_show, name: "Extreme Cake Makers", watching: true}
    Given!(:episode){tv_show.episodes.create name: "Extreme Cake Makers", year: 2018, season: 2, episode: 1, download_at: download_at, watched: false}
    Given{create :episode_release, episode: episode, downloaded: true, resolution: "720p"}
    Then{expect(episode.reload.download_at).to be > download_at}
  end

  context "when adding a killer release to an existing episode which has already been downloaded but not watched. The new episode is not the best" do
    Given(:download_at){Date.today - 3.days}
    Given!(:tv_show){create :tv_show, name: "Extreme Cake Makers", watching: true}
    Given!(:episode){tv_show.episodes.create name: "Extreme Cake Makers", year: 2018, season: 2, episode: 1, download_at: download_at, watched: false}
    Given{create :episode_release, episode: episode}
    Then{expect(episode.reload.download_at).to be > download_at}
  end

  context "when adding a killer release to an existing episode which has already been downloaded and watched" do
    Given(:download_at){Date.yesterday}
    Given!(:tv_show){create :tv_show, name: "Extreme Cake Makers", watching: true}
    Given!(:episode){tv_show.episodes.create name: "Extreme Cake Makers", year: 2018, season: 2, episode: 1, download_at: download_at, watched: true}
    Then{expect(episode.reload.download_at).to eq download_at}
    And{expect(episode.releases.size).to eq 2}
  end
end
