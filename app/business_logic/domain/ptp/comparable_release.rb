module Domain
  module PTP
    class ComparableRelease < SimpleDelegator
      RESOLUTIONS = ["720p", "1080i", "1080p"]
      CONTAINERS = ["mkv"]

      extend Comparable

      def <=>(other)
        resolution_comparison = resolution_points <=> other.resolution_points
        return resolution_comparison unless resolution_comparison == 0

        return container_points <=> other.container_points
      end

      def resolution_points
        RESOLUTIONS.index(resolution) || -1
      end

      def container_points
        CONTAINERS.index(container) || -1
      end
    end
  end
end
