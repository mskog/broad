module Domain
  module BTN
    class Release < SimpleDelegator
      RESOLUTIONS = %w[720p 1080i 1080p 2160p].freeze
      SOURCES = %w[hdtv webrip web-dl].freeze

      extend Comparable

      # TODO: No tests. Tested through the Domain::BTN::Episode class
      def killer?
        %w[1080p 2160p].include? resolution
      end

      def exists?
        Faraday.head(url).headers.key? "content-disposition"
      end

      def <=>(other)
        resolution_comparison = resolution_points <=> other.resolution_points
        return resolution_comparison unless resolution_comparison == 0
        source_points <=> other.source_points
      end

      def resolution_points
        RESOLUTIONS.index(resolution) || -1
      end

      def source_points
        SOURCES.index(source) || -1
      end
    end
  end
end
