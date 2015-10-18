module Domain
  module PTP
    module ReleaseRules
      class Waitlist
        def initialize(release)
          @release = release
        end

        def acceptable?
           no_3d? && bluray? && no_commentary_or_extras? && mkv_container?
        end

        private

        def no_3d?
          !@release.version_attributes.include?("3d")
        end

        def bluray?
          @release.source == 'blu-ray'
        end

        def no_commentary_or_extras?
          (['extras', 'with_commentary'] & @release.version_attributes).empty?
        end

        def mkv_container?
          @release.container == 'mkv'
        end
      end
    end
  end
end
