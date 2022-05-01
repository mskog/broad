module Domain
  module Btn
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
      end

      def build_episode
        @episode ||= @show.episodes.find_or_create_by(entry_attributes) do |episode|
          episode.published_at = @entry.published_at
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

      def build_release
        @episode.releases.find_or_initialize_by(release_attributes)
      end
    end
  end
end
