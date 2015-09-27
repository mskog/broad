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
          Release.new(torrent)
        end
      end
    end
  end
end
