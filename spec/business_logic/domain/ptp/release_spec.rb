require 'spec_helper'

describe Domain::PTP::Release do
  subject{described_class.new(movie_release)}

  describe "#download_url" do
    Given(:movie_release){build_stubbed :movie_release}
    When(:result){subject.download_url}
    Then{expect(result).to eq "http://passthepopcorn.me/torrents.php?action=download&id=#{movie_release.ptp_movie_id}&authkey=#{movie_release.auth_key}&torrent_pass=#{ENV['PTP_PASSKEY']}"}
  end
end
