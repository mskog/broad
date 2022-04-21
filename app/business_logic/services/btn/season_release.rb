module Services
  module Btn
    class SeasonRelease < Dry::Struct
      transform_keys(&:to_sym)

      REGEX = /(?<name>.*) - S(?<season>\d+)E(?<episode>\d+)\s\[\s(?<year>\d+)\s\]\s\[\s(?<file_type>\w+)\s\|\s(?<file_encoding>[^\s]+)\s\|\s(?<source>[^\s]+)\s\|\s(?<resolution>[^\s]+)/.freeze

      attribute :title, Types::String
      attribute? :name, Types::String
      attribute :url, Types::String
      attribute :published_at, Types::Time

      # Data attributes
      attribute :season, Types::Integer
      attribute? :episode, Types::Integer
      attribute? :year, Types::Integer
      attribute :file_type, Types::DowncasedString
      attribute :file_encoding, Types::DowncasedString
      attribute :source, Types::DowncasedString
      attribute :resolution, Types::String

      def self.from_api_entry(entry)
        season_episode = Season.build(entry["GroupName"])

        attributes = {
          season: season_episode.season,
          file_type: entry["Container"],
          file_encoding: entry["Codec"],
          source: entry["Source"],
          resolution: entry["Resolution"],
          title: entry["ReleaseName"],
          url: entry["DownloadURL"],
          published_at: Time.zone.at(entry["Time"].to_i)
        }
        new attributes
      end

      class Season < Dry::Struct
        transform_keys(&:to_sym)

        attribute :season, Types::Coercible::Integer

        def self.build(string)
          matches = string.match(/Season (?<season>\d+)/)
          if matches
            new(season: matches[1])
          else
            new(season: 0)
          end
        end
      end
    end
  end
end
