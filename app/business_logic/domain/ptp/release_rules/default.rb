module Domain
  module PTP
    module ReleaseRules
      class Default
        def initialize(release)
          @release = release
        end

        def acceptable?
          has_seeders? && not_3d? && not_cam_or_ts?
        end

        private

        def has_seeders?
          @release.seeders > 0
        end

        def not_3d?
          (@release.version_attributes & %w(3d 3d_half_sbs)).empty?
        end

        def not_cam_or_ts?
          !['ts', 'cam'].include?(@release.source)
        end
      end
    end
  end
end
