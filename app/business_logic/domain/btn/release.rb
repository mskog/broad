module Domain
  module BTN
    class Release
      include Virtus.model

      REGEX = /(?<name>.*) - S(?<season>\d+)E(?<episode>\d+)\s\[\s(?<year>\d+)\s\]\s\[\s(?<file_type>\w+)\s\|\s(?<file_encoding>[^\s]+)\s\|\s(?<source>[^\s]+)\s\|\s(?<resolution>[^\s]+)/

      attribute :title, String
      attribute :url, String
      attribute :published_at, Time

      # Data attributes
      attribute :name, String
      attribute :season, Integer
      attribute :episode, Integer
      attribute :year, Integer
      attribute :file_type, String
      attribute :file_encoding, String
      attribute :source, String
      attribute :resolution, String

      def self.from_feed_entry(entry)
        matchdata = REGEX.match(entry.title)
        return NullRelease.new unless matchdata.present?
        new Hash[matchdata.names.zip(matchdata.captures)].merge(title: entry.title, url: entry.url, published_at: entry.published)
      end

      def file_type=(file_type)
        super(file_type.downcase)
      end

      def source=(source)
        super(source.downcase)
      end

      NullRelease = Naught.build do |config|
        config.mimic Release
      end
    end
  end
end
