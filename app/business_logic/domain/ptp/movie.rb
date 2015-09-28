module Domain
  module PTP
    class Movie
      include Virtus.model

      attribute :title
      attribute :cover
      attribute :auth_key

      def initialize(data, auth_key)
        @data = data
        hash = {auth_key: auth_key}
        super(data.each_with_object(hash) do |(key, value), new_hash|
          new_hash[key.to_s.underscore.downcase] = value
        end)
      end

      def releases
        @releases ||= @data['Torrents'].map do |torrent|
          ComparableRelease.new(Domain::PTP::Release.new(torrent))
        end
      end

      def best_release
        AcceptableReleases.new(releases).sort.last
      end

      def download_url(release)
        "http://passthepopcorn.me/torrents.php?action=download&id=#{release.id}&authkey=#{auth_key}&torrent_pass=#{ENV['PTP_PASSKEY']}"
      end
    end
  end
end
