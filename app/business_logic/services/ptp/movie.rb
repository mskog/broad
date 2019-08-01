module Services
  module PTP
    class Movie
      include Virtus.model

      attribute :title
      attribute :auth_key
      attribute :imdb_id

      attribute :releases

      def initialize(data, auth_key)
        @data = data
        super(Array(data).each_with_object({}) do |(key, value), new_hash|
          new_hash[key.to_s.underscore.downcase] = value
        end)
        self.auth_key = auth_key
      end

      def releases
        # TODO: specs for guard clause
        return [] unless @data
        @data["Torrents"].map do |torrent|
          Services::PTP::Release.new(torrent)
        end
      end
    end
  end
end
