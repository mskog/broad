module Services
  module PTP
    class Movie
      include Virtus.model

      attribute :title

      attribute :releases

      def initialize(data)
        @data = data
        super(Array(data).each_with_object({}) do |(key, value), new_hash|
                 new_hash[key.to_s.underscore.downcase] = value
               end)
      end

      def releases
        # TODO specs for guard clause
        return [] unless @data
        @data['Torrents'].map do |torrent|
          Services::PTP::Release.new(torrent)
        end
      end
    end
  end
end
