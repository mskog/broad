module Services
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
        if matchdata.present?
          new Hash[matchdata.names.zip(matchdata.captures)].merge(title: entry.title, url: entry.url, published_at: entry.published)
        else
          NullRelease.new
        end
      end

      def self.from_api_entry(entry)
        season_episode = SeasonEpisode.new(entry['GroupName'])

        attributes = {
          name: entry['Series'],
          season: season_episode.season,
          episode: season_episode.episode,
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

      private

      class SeasonEpisode
        include Virtus.model

        attribute :season, Integer
        attribute :episode, Integer

        def initialize(string)
          matches = string.match(/S(?<season>\d+)E(?<episode>\d+)/)
          if matches
            super(season: matches[1], episode: matches[2])
          else
            super(season: 0, episode: 0)
          end
        end
      end

      NullRelease = Naught.build do |config|
        config.mimic Release
      end
    end
  end
end
