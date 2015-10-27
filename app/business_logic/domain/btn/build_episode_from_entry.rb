module Domain
  module BTN
    class BuildEpisodeFromEntry
      def initialize(show, entry)
        @entry = entry
        @show = show
        build_episode
        build_release
        set_download_at
      end

      def episode
        Domain::BTN::Episode.new(@episode)
      end

      private

      def build_episode
        @episode = @show.episodes.find_or_create_by(@entry.to_h.slice(:name, :episode, :year, :season)) do |episode|
          episode.published_at = @entry.published_at
        end
      end

      def set_download_at
        episode.download_at = DateTime.now + episode.download_delay.hours
      end

      def build_release
        @episode.releases.find_or_initialize_by(@entry.to_h.except(:name, :episode, :year, :season))
      end
    end
  end
end
