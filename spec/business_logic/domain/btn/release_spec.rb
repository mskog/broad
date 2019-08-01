require "spec_helper"

describe Domain::BTN::Release, :nodb do
  subject{described_class.new(OpenStruct.new(url: url))}

  describe "#exists?" do
    Given(:url){"http://someurl.com/sometorrent.torrent"}

    context "a release that exists" do
      Given(:raw_response_file){File.new("spec/fixtures/btn/existing_torrent.txt")}
      Given do
        stub_request(:head, url.to_s).to_return(raw_response_file)
      end
      Then{expect(subject).to exist}
    end

    context "a release that does not exist" do
      Given(:raw_response_file){File.new("spec/fixtures/btn/missing_torrent.txt")}
      Given do
        stub_request(:head, url.to_s).to_return(raw_response_file)
      end
      Then{expect(subject).to_not exist}
    end
  end

  describe "Comparisons" do
    When(:result){releases.sort}

    context "with a web-dl, hdtv and webrip release" do
      Given(:release_webdl_720p){described_class.new(OpenStruct.new(resolution: "720p", source: "web-dl"))}
      Given(:release_webdl_1080p){described_class.new(OpenStruct.new(resolution: "1080p", source: "web-dl"))}
      Given(:release_hdtv_1080p){described_class.new(OpenStruct.new(resolution: "1080p", source: "hdtv"))}
      Given(:release_webrip_1080p){described_class.new(OpenStruct.new(resolution: "1080p", source: "webrip"))}
      Given(:release_hdtv_480p){described_class.new(OpenStruct.new(resolution: "480p", source: "hdtv"))}
      Given(:releases){[release_webrip_1080p, release_webdl_1080p, release_webdl_720p, release_hdtv_1080p, release_hdtv_480p]}
      Then{expect(result).to eq [release_hdtv_480p, release_webdl_720p, release_hdtv_1080p, release_webrip_1080p, release_webdl_1080p]}
    end
  end
end
