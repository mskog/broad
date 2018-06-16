module Services
  module BTN
    class SeasonRelease
      include Virtus.model

      REGEX = /(?<name>.*) - S(?<season>\d+)E(?<episode>\d+)\s\[\s(?<year>\d+)\s\]\s\[\s(?<file_type>\w+)\s\|\s(?<file_encoding>[^\s]+)\s\|\s(?<source>[^\s]+)\s\|\s(?<resolution>[^\s]+)/

      attribute :title, String
      attribute :url, String
      attribute :published_at, Time

      # Data attributes
      attribute :season, Integer
      attribute :year, Integer
      attribute :file_type, String
      attribute :file_encoding, String
      attribute :source, String
      attribute :resolution, String

      def self.from_api_entry(entry)
        season_episode = Season.new(entry['GroupName'])

        attributes = {
          season: season_episode.season,
          file_type: entry['Container'],
          file_encoding: entry['Codec'],
          source: entry['Source'],
          resolution: entry['Resolution'],
          title: entry['ReleaseName'],
          url: entry['DownloadURL'],
          published_at: Time.at(entry['Time'].to_i)
        }
        new attributes
      end

      def file_type
        super.downcase
      end

      def file_encoding
        super.downcase
      end

      def source
        super.downcase
      end

      class Season
        include Virtus.model

        attribute :season, Integer

        def initialize(string)
          matches = string.match(/Season (?<season>\d+)/)
          if matches
            super(season: matches[1])
          else
            super(season: 0)
          end
        end
      end
    end
  end
end
