module Domain
  module BTN
    class BuildEpisodeFromEntry
      def initialize(show, entry, episode: nil)
        @entry = entry
        @show = show
        @episode = episode
        build
      end

      attr_reader :episode

      private

      def build
        build_episode
        build_release
        set_download_at
      end

      def domain_episode
        @domain_episde ||= Domain::BTN::Episode.new(@episode)
      end

      def build_episode
        season = @show.seasons.find_or_initialize_by(number: @entry.season)

        @episode ||= @show.episodes.find_or_create_by(entry_attributes) do |episode|
          episode.published_at = @entry.published_at
          episode.season = season
        end
      end

      def entry_attributes
        attributes = @entry.to_h.slice(:name, :episode, :year)
        attributes[:season_number] = @entry.to_h[:season]
        attributes[:name].try(:strip!)
        attributes
      end

      def release_attributes
        attributes = @entry.to_h.except(:name, :episode, :year, :season)
        attributes[:title].strip!
        attributes
      end

      def set_download_at
        episode.download_at = domain_episode.download_at
      end

      def build_release
        @episode.releases.find_or_initialize_by(release_attributes)
      end
    end
  end
end
