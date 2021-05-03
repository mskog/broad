module Services
  module PTP
    class TopMovie
      include Virtus.model

      attribute :title
      attribute :imdb_id
      attribute :year
      attribute :cover
      attribute :tags, [String]
      attribute :imdb_rating
      attribute :mc_url
      attribute :ptp_rating
      attribute :youtube_id
      attribute :synopsis

      def initialize(data)
        @data = data
        super(Array(data).each_with_object({}) do |(key, value), new_hash|
          new_hash[key.to_s.underscore.downcase] = value
        end)
      end

      def imdb_id
        "tt#{super}"
      end
    end
  end
end
