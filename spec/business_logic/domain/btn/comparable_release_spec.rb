require 'spec_helper'

describe Domain::BTN::ComparableRelease do
  describe "Comparisons" do
    When(:result){releases.sort}

    context "with a web-dl, hdtv and webrip release" do
      Given(:release_webdl_720p){described_class.new(OpenStruct.new(resolution: '720p', source: 'web-dl'))}
      Given(:release_webdl_1080p){described_class.new(OpenStruct.new(resolution: '1080p', source: 'web-dl'))}
      Given(:release_hdtv_1080p){described_class.new(OpenStruct.new(resolution: '1080p', source: 'hdtv'))}
      Given(:release_webrip_1080p){described_class.new(OpenStruct.new(resolution: '1080p', source: 'webrip'))}
      Given(:release_hdtv_480p){described_class.new(OpenStruct.new(resolution: '480p', source: 'hdtv'))}
      Given(:releases){[release_webrip_1080p, release_webdl_1080p, release_webdl_720p, release_hdtv_1080p, release_hdtv_480p]}
      Then{expect(result).to eq [release_hdtv_480p, release_webdl_720p, release_hdtv_1080p, release_webrip_1080p, release_webdl_1080p]}
    end
  end
end
