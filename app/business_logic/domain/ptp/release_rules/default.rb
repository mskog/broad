module Domain
  module PTP
    module ReleaseRules
      class Default
        def initialize(release)
          @release = release
        end

        def acceptable?
          has_seeders? && not_3d? && not_cam_or_ts? && no_commentary_or_extras?
        end

        private

        def has_seeders?
          @release.seeders > 0
        end

        def not_3d?
          !@release.version_attributes.include?("3d")
        end

        def not_cam_or_ts?
          !['ts', 'cam'].include?(@release.source)
        end

        def no_commentary_or_extras?
          (['extras', 'with_commentary'] & @release.version_attributes).empty?
        end
      end
    end
  end
end
