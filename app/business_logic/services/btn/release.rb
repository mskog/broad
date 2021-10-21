module Services
  module BTN
    class Release < Dry::Struct
      transform_keys do |key|
        key.to_s.underscore.downcase.to_sym
      end

      REGEX = /(?<name>.*) - S(?<season>\d+)E(?<episode>\d+)\s\[\s(?<year>\d+)\s\]\s\[\s(?<file_type>\w+)\s\|\s(?<file_encoding>[^\s]+)\s\|\s(?<source>[^\s]+)\s\|\s(?<resolution>[^\s]+)/.freeze

      attribute :title, Types::String
      attribute :url, Types::String
      attribute :published_at, Types::JSON::Time

      # Data attributes
      attribute :name, Types::String
      attribute :season, Types::IntegerWithLeadingZero
      attribute :episode, Types::IntegerWithLeadingZero
      attribute? :year, Types::Coercible::Integer
      attribute? :file_type, Types::DowncasedString
      attribute :file_encoding, Types::DowncasedString
      attribute :source, Types::DowncasedString
      attribute :resolution, Types::String
      attribute? :hdr, Types::Bool

      def self.from_feed_entry(entry)
        matchdata = REGEX.match(entry.title)
        if matchdata.present?
          new Hash[matchdata.names.zip(matchdata.captures)].merge(title: entry.title, url: entry.url, published_at: entry.published)
        else
          NullRelease.new
        end
      end

      def self.from_api_entry(entry)
        season_episode = SeasonEpisode.build(entry["GroupName"])

        attributes = {
          name: entry["Series"],
          season: season_episode.season,
          episode: season_episode.episode,
          file_type: entry["Container"],
          file_encoding: entry["Codec"],
          source: entry["Source"],
          resolution: entry["Resolution"],
          title: entry["ReleaseName"],
          url: entry["DownloadURL"],
          published_at: Time.at(entry["Time"].to_i),
          hdr: entry["ReleaseName"].include?(".HDR.")
        }
        new attributes
      end

      class SeasonEpisode < Dry::Struct
        transform_keys do |key|
          key.to_s.underscore.downcase.to_sym
        end

        attribute :season, Types::Coercible::Integer
        attribute :episode, Types::IntegerWithLeadingZero

        def self.build(string)
          matches = string.match(/S(?<season>\d+)E(?<episode>\d+)/)
          if matches
            new(season: matches[1], episode: matches[2])
          else
            new(season: 0, episode: 0)
          end
        end
      end

      NullRelease = Naught.build do |config|
        config.mimic Release
      end
    end
  end
end
