module Services
  module PTP
    class Release
      include Virtus.model

      attribute :id, Integer
      attribute :checked, Boolean
      attribute :codec, String
      attribute :container, String
      attribute :golden_popcorn, Boolean
      attribute :leechers, Integer
      attribute :seeders, Integer
      attribute :quality, String
      attribute :release_name, String
      attribute :remaster_title, String
      attribute :resolution, String
      attribute :scene, Boolean
      attribute :size, Integer
      attribute :snatched, Integer
      attribute :source, String
      attribute :upload_time, DateTime

      attribute :version_attributes, Array

      attribute :width, Integer
      attribute :height, Integer

      def initialize(data)
        super(self.class.convert_data(data))
      end

      def version_attributes
        remaster_title.to_s.split('/').map do |item|
          item.strip.gsub(' ', '_')
        end
      end

      private

      def self.convert_data(data)
        data.each_with_object({}) do |(key, value), new_hash|
          converted_value = value.is_a?(String) ? value.downcase : value
          new_hash[key.to_s.underscore] = converted_value
        end
      end
    end
  end
end
