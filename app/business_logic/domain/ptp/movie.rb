module Domain
  module PTP
    class Movie
      include Virtus.model

      attribute :title
      attribute :cover

      def initialize(data)
        @data = data
        super(data.each_with_object({}) do |(key, value), new_hash|
          new_hash[key.to_s.underscore] = value
        end)
      end

      def releases
        @releases ||= @data['Torrents'].map do |torrent|
          ComparableRelease.new(Release.new(torrent))
        end
      end

      def best_release
        AcceptableReleases.new(releases).sort.last
      end
    end
  end
end
