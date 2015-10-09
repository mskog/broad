require 'spec_helper'

describe Services::BTN::Release, :nodb do
  subject{described_class.from_feed_entry(entry)}
  Given(:url){'http://www.example.com/something.torrent'}
  Given(:published){'2015-01-01'}
  Given(:entry){OpenStruct.new(title: title, url: url, published: published)}

  describe "Creation" do
    context "with a WEB-DL release" do
      Given(:title){"Hannibal - S03E06 [ 2015 ] [ MKV | h.264 | WEB-DL | 1080p | FastTorrent ] [ Uploader: notthegrinch ]  [ Hannibal.S03E06.1080p.WEB-DL.DD5.1.H.264-HDB ]"}
      Then{expect(subject.name).to eq 'Hannibal'}
      And{expect(subject.season).to eq 3}
      And{expect(subject.episode).to eq 6}
      And{expect(subject.year).to eq 2015}
      And{expect(subject.file_type).to eq 'mkv'}
      And{expect(subject.file_encoding).to eq 'h.264'}
      And{expect(subject.source).to eq 'web-dl'}
      And{expect(subject.resolution).to eq '1080p'}
      And{expect(subject.title).to eq title}
      And{expect(subject.url).to eq url}
      And{expect(subject.published_at).to eq Time.parse(published)}
    end

    context "with an HDTV release" do
      Given(:title){"Natural World - S35E08 [ 2015 ] [ MKV | x264 | HDTV | 720p | Scene ] [ Uploader: deltron ] [ natural.world.s35e08.irelands.wild.river.the.mighty.shannon.720p.hdtv.x264-c4tv ]"}
      Then{expect(subject.name).to eq  'Natural World'}
      And{expect(subject.season).to eq 35}
      And{expect(subject.episode).to eq 8}
      And{expect(subject.year).to eq 2015}
      And{expect(subject.file_type).to eq 'mkv'}
      And{expect(subject.file_encoding).to eq 'x264'}
      And{expect(subject.source).to eq 'hdtv'}
      And{expect(subject.resolution).to eq '720p'}
      And{expect(subject.title).to eq title}
      And{expect(subject.url).to eq url}
      And{expect(subject.published_at).to eq Time.parse(published)}
    end

    context "with something that cannot be parsed correctly" do
      Given(:title){"Rick and Morty - ATX Television Festival 2015 Panel [ 2015 ] [ MKV | h.264 | WEB-DL | 1080p | FastTorrent ] [ Uploader: Werner ] [ Rick.and.Morty.S02.ATX.Television.Festival.1080p.WEB-DL.AAC2.0.H.264-RARBG ] "}
      Then{expect(subject.name).to be_nil}
    end
  end
end
