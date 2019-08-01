require "spec_helper"

describe Services::BTN::SeasonRelease, :nodb do
  Given(:url){"http://www.example.com/something.torrent"}
  Given(:published){"2015-01-01"}
  Given(:entry){OpenStruct.new(title: title, url: url, published: published)}

  describe "Creation by api entry" do
    subject{described_class.from_api_entry(entry)}

    context "with a WEB-DL release" do
      Given(:entry) do
        {
          "GroupName" => "Season 1",
          "GroupID" => "399895",
          "TorrentID" => "840515",
          "SeriesID" => "51362",
          "Series" => "Taboo (2017)",
          "SeriesBanner" => "//cdn2.broadcasthe.net/tvdb/banners/graphical/292157-g3.jpg",
          "SeriesPoster" => "//cdn2.broadcasthe.net/tvdb/banners/posters/292157-1.jpg",
          "YoutubeTrailer" => "http://www.youtube.com/watch?v=W1fiijqrKuc",
          "Category" => "Season",
          "Snatched" => "97",
          "Seeders" => "25",
          "Leechers" => "0",
          "Source" => "Bluray",
          "Container" => "MKV",
          "Codec" => "H.264",
          "Resolution" => "720p",
          "Origin" => "P2P",
          "ReleaseName" => "Taboo.2017.S01.720p.BluRay.DD5.1.x264-DON",
          "Size" => "22629451483",
          "Time" => "1506960694",
          "TvdbID" => "292157",
          "TvrageID" => "0",
          "ImdbID" => "3647998",
          "InfoHash" => "D691D100A56CE0980ED38A60904A3FE55C5F4748",
          "DownloadURL" =>
            "www.example.com"
        }
      end
      Then{expect(subject.season).to eq 1}
      And{expect(subject.year).to be_nil}
      And{expect(subject.file_type).to eq "mkv"}
      And{expect(subject.file_encoding).to eq "h.264"}
      And{expect(subject.source).to eq "bluray"}
      And{expect(subject.resolution).to eq "720p"}
      And{expect(subject.title).to eq "Taboo.2017.S01.720p.BluRay.DD5.1.x264-DON"}
      And{expect(subject.url).to eq "www.example.com"}
      And{expect(subject.published_at).to eq "2017-10-02 18:11:34.000000000 +0200"}
    end
  end
end
