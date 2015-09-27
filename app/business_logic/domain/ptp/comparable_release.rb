module Domain
  module PTP
    class ComparableRelease < SimpleDelegator
      RESOLUTIONS = ["720p", "1080i", "1080p"]

      extend Comparable

      def <=>(other)
        resolution_points <=> other.resolution_points
      end

      def resolution_points
        RESOLUTIONS.index(resolution) || -1
      end
    end
  end
end
