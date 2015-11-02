require 'spec_helper'

describe Services::FetchAndPersistFeedEntries do
  Given(:url){"http://www.example.com/foobar.rss"}
  Given(:fixture){File.open('spec/fixtures/btn_feed_multiple_releases.xml').read}
  Given{stub_request(:get, url).to_return(body: fixture)}

  Given(:published_since){"2015-07-19 11:08:00 +0000"}
  subject{described_class.new(url, published_since)}

  When{subject.perform}

  context "running once" do
    Given(:hannibal_show){TvShow.find_by_name('Hannibal')}
    Given(:hannibal_episode){hannibal_show.episodes.first}
    Given(:defiance_show){TvShow.find_by_name('Defiance')}
    Given(:defiance_episode){defiance_show.episodes.first}
    Given(:defiance_releases){defiance_episode.releases.order(id: :desc)}
    Given(:first_defiance_release){defiance_releases.first}
    Given(:last_defiance_release){defiance_releases.last}
    Then{expect(hannibal_show.episodes.first.download_at).to be <= DateTime.now}
    And{expect(defiance_show.name).to eq 'Defiance'}
    And{expect(Episode.count).to eq 7}
    And{expect(defiance_show.episodes.count).to eq 1}
    And{expect(EpisodeRelease.count).to eq 8}
    And{expect(defiance_episode.releases.count).to eq 2}
    And{expect(defiance_episode.season).to eq 3}
    And{expect(defiance_episode.episode).to eq 7}
    And{expect(defiance_episode.year).to eq 2015}
    And{expect(defiance_episode.published_at).to eq "2015-07-19 11:13:33.000000000 +0000"}
    And{expect(defiance_episode.download_at).to be > DateTime.now}

    And{expect(first_defiance_release.title).to eq 'Defiance - S03E07 [ 2015 ] [ MKV | h.264 | WEB-DL | 720p | FastTorrent ] [ Uploader: IceFreak ]  [ Defiance.S03E07.720p.WEB-DL.DD5.1.H.264-ECI ] '}
    And{expect(first_defiance_release.url).to eq 'https://broadcasthe.net/torrents.php?action=download&authkey=sdfsdfsdfsdf&torrent_pass=sdfsfsdfsdfsdfsdfs&id=532259'}
    And{expect(first_defiance_release.file_type).to eq 'mkv'}
    And{expect(first_defiance_release.file_encoding).to eq 'h.264'}
    And{expect(first_defiance_release.source).to eq 'web-dl'}
    And{expect(first_defiance_release.resolution).to eq '720p'}
    And{expect(first_defiance_release.published_at).to eq '2015-07-19 11:10:21.000000000 +0000'}

    And{expect(last_defiance_release.resolution).to eq '720p'}
  end

  context "running twice" do
    When{subject.perform}
    Then{expect(TvShow.count).to eq 7}
    And{expect(Episode.count).to eq 7}
    And{expect(EpisodeRelease.count).to eq 8}
  end

  context "adding releases to existing episodes" do
    Given(:download_at){Date.yesterday}
    Given(:fixture){File.open('spec/fixtures/btn_feed_unparsable_entries.xml').read}
    Given!(:tv_show){create :tv_show, name: 'Hannibal'}
    Given!(:episode){tv_show.episodes.create name: 'Hannibal', year: 2015, season: 3, episode: 7, download_at: download_at}
    Then{expect(episode.reload.download_at).to eq download_at}
  end

  context "adding a killer release to an existing episode" do
    Given(:download_at){Date.tomorrow}
    Given(:fixture){File.open('spec/fixtures/btn_feed_killer.xml').read}
    Given!(:tv_show){create :tv_show, name: 'Hannibal'}
    Given!(:episode){tv_show.episodes.create name: 'Hannibal', year: 2015, season: 3, episode: 7, download_at: download_at}
    Then{expect(episode.reload.download_at).to be < download_at}
  end

  context "adding a killer release to an existing episode which has already been downloaded" do
    Given(:download_at){Date.yesterday}
    Given(:fixture){File.open('spec/fixtures/btn_feed_killer.xml').read}
    Given!(:tv_show){create :tv_show, name: 'Hannibal'}
    Given!(:episode){tv_show.episodes.create name: 'Hannibal', year: 2015, season: 3, episode: 7, download_at: download_at}
    Then{expect(episode.reload.download_at).to eq download_at}
    And{expect(episode.releases.size).to eq 0}
  end

  context "with a feed containing unparsable entries" do
    Given(:fixture){File.open('spec/fixtures/btn_feed_unparsable_entries.xml').read}
    Then{expect(Episode.count).to eq 1}
    And{expect(Episode.last.name).to eq 'Hannibal'}
  end
end
