module Domain
  module PTP
    class Release < SimpleDelegator
      def download_url
        "http://passthepopcorn.me/torrents.php?action=download&id=#{ptp_movie_id}&authkey=#{auth_key}&torrent_pass=#{ENV['PTP_PASSKEY']}"
      end
    end
  end
end
