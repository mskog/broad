require "spec_helper"

describe Services::Btn::Release, :nodb do
  Given(:url){"http://www.example.com/something.torrent"}
  Given(:published){"2015-01-01"}
  Given(:entry){OpenStruct.new(title: title, url: url, published: published)}

  describe "Creation by feed entry" do
    subject{described_class.from_feed_entry(entry)}

    context "with a WEB-DL release" do
      Given(:title){"Hannibal - S03E06 [ 2015 ] [ MKV | h.264 | WEB-DL | 1080p | FastTorrent ] [ Uploader: notthegrinch ]  [ Hannibal.S03E06.1080p.WEB-DL.DD5.1.H.264-HDB ]"}
      Then{expect(subject.name).to eq "Hannibal"}
      And{expect(subject.season).to eq 3}
      And{expect(subject.episode).to eq 6}
      And{expect(subject.year).to eq 2015}
      And{expect(subject.file_type).to eq "mkv"}
      And{expect(subject.file_encoding).to eq "h.264"}
      And{expect(subject.source).to eq "web-dl"}
      And{expect(subject.resolution).to eq "1080p"}
      And{expect(subject.title).to eq title}
      And{expect(subject.url).to eq url}
      And{expect(subject.published_at).to eq Time.parse(published)}
      And{expect(subject.hdr).to be_falsy}
    end

    context "with an HDTV release" do
      Given(:title){"Natural World - S35E08 [ 2015 ] [ MKV | x264 | HDTV | 720p | Scene ] [ Uploader: deltron ] [ natural.world.s35e08.irelands.wild.river.the.mighty.shannon.720p.hdtv.x264-c4tv ]"}
      Then{expect(subject.name).to eq  "Natural World"}
      And{expect(subject.season).to eq 35}
      And{expect(subject.episode).to eq 8}
      And{expect(subject.year).to eq 2015}
      And{expect(subject.file_type).to eq "mkv"}
      And{expect(subject.file_encoding).to eq "x264"}
      And{expect(subject.source).to eq "hdtv"}
      And{expect(subject.resolution).to eq "720p"}
      And{expect(subject.title).to eq title}
      And{expect(subject.url).to eq url}
      And{expect(subject.published_at).to eq Time.parse(published)}
      And{expect(subject.hdr).to be_falsy}
    end

    context "with a DV release" do
      Given(:title){"GRID - S01E10 [ 2022 ] [ MKV | H.265 | WEB-DL | 2160p | FastTorrent | Foreign ] [ Uploader: Anonymous ] [ Grid.S01E10.DV.2160p.DSNP.WEB-DL.DDP5.1.H.265-FourOneFiveThreeFiveOne ]"}
      Then{expect(subject.name).to eq "GRID"}
      And{expect(subject.season).to eq 1}
      And{expect(subject.episode).to eq 10}
      And{expect(subject.year).to eq 2022}
      And{expect(subject.file_type).to eq "mkv"}
      And{expect(subject.file_encoding).to eq "h.265"}
      And{expect(subject.source).to eq "web-dl"}
      And{expect(subject.resolution).to eq "2160p"}
      And{expect(subject.title).to eq title}
      And{expect(subject.url).to eq url}
      And{expect(subject.published_at).to eq Time.parse(published)}
      And{expect(subject.hdr).to be_falsy}
      And{expect(subject.dolby_vision).to be_truthy}
    end

    context "with something that cannot be parsed correctly" do
      Given(:title){"Rick and Morty - ATX Television Festival 2015 Panel [ 2015 ] [ MKV | h.264 | WEB-DL | 1080p | FastTorrent ] [ Uploader: Werner ] [ Rick.and.Morty.S02.ATX.Television.Festival.1080p.WEB-DL.AAC2.0.H.264-RARBG ] "}
      Then{expect(subject.name).to be_nil}
    end
  end

  describe "Creation by api entry" do
    subject{described_class.from_api_entry(entry)}

    context "with a WEB-DL release" do
      Given(:entry) do
        {
          GroupName: "S10E06",
          GroupID: "488327",
          TorrentID: "953987",
          SeriesID: "2116",
          Series: "The Real Housewives of New York City",
          SeriesBanner: "banner",
          SeriesPoster: "poster",
          YoutubeTrailer: "http://www.youtube.com/v/ORQdj2QzmOw",
          Category: "Episode",
          Snatched: "49",
          Seeders: "32",
          Leechers: "0",
          Source: "WEB-DL",
          Container: "MKV",
          Codec: "H.264",
          Resolution: "1080p",
          Origin: "Internal",
          ReleaseName: "The.Real.Housewives.of.New.York.City.S10E06.Grief.and.Relief.1080p.AMZN.WEB-DL.DDP5.1.H.264-NTb",
          Size: "4500335696",
          Time: "1525954948",
          TvdbID: "84669",
          TvrageID: "18525",
          ImdbID: "1191056",
          InfoHash: "C9C88DC2EF3AAA9470ACECBC27777A128BE8FD68",
          DownloadURL: "example.com"
        }.stringify_keys
      end
      Then{expect(subject.name).to eq "The Real Housewives of New York City"}
      And{expect(subject.season).to eq 10}
      And{expect(subject.episode).to eq 6}
      And{expect(subject.year).to be_nil}
      And{expect(subject.file_type).to eq "mkv"}
      And{expect(subject.file_encoding).to eq "h.264"}
      And{expect(subject.source).to eq "web-dl"}
      And{expect(subject.resolution).to eq "1080p"}
      And{expect(subject.title).to eq "The.Real.Housewives.of.New.York.City.S10E06.Grief.and.Relief.1080p.AMZN.WEB-DL.DDP5.1.H.264-NTb"}
      And{expect(subject.url).to eq "example.com"}
      And{expect(subject.published_at).to eq "2018-05-10 14:22:28.000000000 +0200"}
      And{expect(subject.hdr).to be_falsy}
    end

    context "with a release which does not match a season or episode" do
      Given(:entry) do
        {
          GroupName: "Season 3 - Talking Saul on Lantern",
          GroupID: "488327",
          TorrentID: "953987",
          SeriesID: "2116",
          Series: "The Real Housewives of New York City",
          SeriesBanner: "banner",
          SeriesPoster: "poster",
          YoutubeTrailer: "http://www.youtube.com/v/ORQdj2QzmOw",
          Category: "Episode",
          Snatched: "49",
          Seeders: "32",
          Leechers: "0",
          Source: "WEB-DL",
          Container: "MKV",
          Codec: "H.264",
          Resolution: "1080p",
          Origin: "Internal",
          ReleaseName: "Season 3 - Talking Saul on Lantern",
          Size: "4500335696",
          Time: "1525954948",
          TvdbID: "84669",
          TvrageID: "18525",
          ImdbID: "1191056",
          InfoHash: "C9C88DC2EF3AAA9470ACECBC27777A128BE8FD68",
          DownloadURL: "example.com"
        }.stringify_keys
      end

      Then{expect(subject.season).to eq 0}
      And{expect(subject.episode).to eq 0}
    end

    context "with a release with hdr" do
      Given(:entry) do
        {
          GroupName: "S01E01",
          GroupID: "696849",
          TorrentID: "1442776",
          SeriesID: "89641",
          Series: "The Falcon and the Winter Soldier",
          SeriesBanner: "//cdn2.broadcasthe.net/tvdb/banners/series/362496/banners/5fd4fea8961c5.jpg",
          SeriesPoster: "//cdn2.broadcasthe.net/tvdb/banners/series/362496/posters/60271980c8a0a/resized_w300.jpg",
          YoutubeTrailer: "https://www.youtube.com/v/IWBsDaFWyTE",
          Category: "Episode",
          Snatched: "179",
          Seeders: "139",
          Leechers: "1",
          Source: "WEBRip",
          Container: "MKV",
          Codec: "H.264",
          Resolution: "1080p",
          Origin: "P2P",
          ReleaseName: "The.Falcon.and.the.Winter.Soldier.S01E01.New.World.Order.1080p.HDR.WEBRip.DDP5.1.Atmos.H.264-MZABI",
          Size: "5265405641",
          Time: "1617400276",
          TvdbID: "362496",
          TvrageID: "41749",
          ImdbID: "9208876",
          InfoHash: "F6AC641C0EC1715EDEF0E6552C075AC0E4BF95B8",
          DownloadURL: "example.com"
        }.stringify_keys
      end

      Then{expect(subject.hdr).to be_truthy}
    end

    context "with a release with dolby vision" do
      Given(:entry) do
        {
          GroupName: "S01E01",
          GroupID: "696849",
          TorrentID: "1442776",
          SeriesID: "89641",
          Series: "The Falcon and the Winter Soldier",
          SeriesBanner: "//cdn2.broadcasthe.net/tvdb/banners/series/362496/banners/5fd4fea8961c5.jpg",
          SeriesPoster: "//cdn2.broadcasthe.net/tvdb/banners/series/362496/posters/60271980c8a0a/resized_w300.jpg",
          YoutubeTrailer: "https://www.youtube.com/v/IWBsDaFWyTE",
          Category: "Episode",
          Snatched: "179",
          Seeders: "139",
          Leechers: "1",
          Source: "WEBRip",
          Container: "MKV",
          Codec: "H.264",
          Resolution: "1080p",
          Origin: "P2P",
          ReleaseName: "The.Falcon.and.the.Winter.Soldier.S01E01.New.World.Order.1080p.DV.WEBRip.DDP5.1.Atmos.H.264-MZABI",
          Size: "5265405641",
          Time: "1617400276",
          TvdbID: "362496",
          TvrageID: "41749",
          ImdbID: "9208876",
          InfoHash: "F6AC641C0EC1715EDEF0E6552C075AC0E4BF95B8",
          DownloadURL: "example.com"
        }.stringify_keys
      end

      Then{expect(subject.hdr).to be_falsy}
      And{expect(subject.dolby_vision).to be_truthy}
    end
  end
end
