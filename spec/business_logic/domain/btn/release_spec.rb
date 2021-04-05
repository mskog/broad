require "spec_helper"

describe Domain::BTN::Release, :nodb do
  subject{described_class.new(OpenStruct.new(url: url))}

  describe "#exists?" do
    Given(:url){"http://someurl.com/sometorrent.torrent"}

    context "with a release that exists" do
      Given(:raw_response_file){File.new("spec/fixtures/btn/existing_torrent.txt")}
      Given do
        stub_request(:head, url.to_s).to_return(raw_response_file)
      end
      Then{expect(subject).to exist}
    end

    context "with a release that does not exist" do
      Given(:raw_response_file){File.new("spec/fixtures/btn/missing_torrent.txt")}
      Given do
        stub_request(:head, url.to_s).to_return(raw_response_file)
      end
      Then{expect(subject).not_to exist}
    end
  end

  describe "Comparisons" do
    When(:result){releases.sort}

    context "with a web-dl, hdtv and webrip release" do
      Given(:release_webdl_720p){described_class.new(OpenStruct.new(resolution: "720p", source: "web-dl", file_encoding: "x264", hdr: false))}
      Given(:release_webdl_1080p){described_class.new(OpenStruct.new(resolution: "1080p", source: "web-dl", file_encoding: "x264", hdr: false))}
      Given(:release_hdtv_1080p){described_class.new(OpenStruct.new(resolution: "1080p", source: "hdtv", file_encoding: "x264", hdr: false))}
      Given(:release_webrip_1080p){described_class.new(OpenStruct.new(resolution: "1080p", source: "webrip", file_encoding: "x264", hdr: false))}
      Given(:release_webrip_2160p){described_class.new(OpenStruct.new(resolution: "2160p", source: "webrip", file_encoding: "x264", hdr: false))}
      Given(:release_webrip_2160p_hdr){described_class.new(OpenStruct.new(resolution: "2160p", source: "webrip", file_encoding: "x264", hdr: true))}
      Given(:release_webrip_2160p265){described_class.new(OpenStruct.new(resolution: "2160p", source: "webrip", file_encoding: "h.265", hdr: false))}
      Given(:release_hdtv_480p){described_class.new(OpenStruct.new(resolution: "480p", source: "hdtv", file_encoding: "x264", hdr: false))}
      Given(:releases){[release_webrip_1080p, release_webdl_1080p, release_webdl_720p, release_hdtv_1080p, release_hdtv_480p, release_webrip_2160p, release_webrip_2160p265, release_webrip_2160p_hdr]}
      Then{expect(result).to eq [release_hdtv_480p, release_webdl_720p, release_hdtv_1080p, release_webrip_1080p, release_webdl_1080p, release_webrip_2160p, release_webrip_2160p265, release_webrip_2160p_hdr]}
    end
  end
end
