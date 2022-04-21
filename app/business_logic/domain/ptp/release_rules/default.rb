module Domain
  module Ptp
    module ReleaseRules
      class Default
        def initialize(release)
          @release = release
        end

        def acceptable?
          has_seeders? && not_3d? && not_cam_or_ts? && not_mp4?
        end

        private

        def has_seeders?
          @release.seeders > 0
        end

        def not_3d?
          (@release.version_attributes & %w[3d 3d_half_sbs]).empty?
        end

        def not_cam_or_ts?
          %w[ts cam].exclude?(@release.source)
        end

        def not_mp4?
          @release.container.downcase != "mp4"
        end
      end
    end
  end
end
