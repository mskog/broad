module Domain
  module PTP
    class ComparableRelease < SimpleDelegator
      COMPARISON_METHODS = %w[resolution container remux].freeze

      RESOLUTIONS = %w[720p 1080i 1080p].freeze
      CONTAINERS = ["mkv"].freeze

      extend Comparable

      def <=>(other)
        COMPARISON_METHODS.each do |method|
          comparison = public_send("#{method}_points") <=> other.public_send("#{method}_points")
          return comparison unless comparison == 0
        end
        size <=> other.size
      end

      def resolution_points
        RESOLUTIONS.index(resolution) || -1
      end

      def container_points
        CONTAINERS.index(container) || -1
      end

      def remux_points
        version_attributes.include?("remux") ? 1 : 0
      end
    end
  end
end
