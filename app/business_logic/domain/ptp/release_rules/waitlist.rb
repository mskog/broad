module Domain
  module PTP
    module ReleaseRules
      class Waitlist
        def initialize(release)
          @release = release
        end

        def acceptable?
           not_3d? && bluray? && mkv_container?
        end

        private

        def not_3d?
          (@release.version_attributes & %w(3d 3d_half_sbs)).empty?
        end

        def bluray?
          @release.source == 'blu-ray'
        end

        def mkv_container?
          @release.container == 'mkv'
        end
      end
    end
  end
end
