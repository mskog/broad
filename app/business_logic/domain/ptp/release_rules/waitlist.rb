module Domain
  module PTP
    module ReleaseRules
      class Waitlist < Default
        def initialize(release)
          @release = release
        end

        def acceptable?
           super && bluray? && mkv_container?
        end

        private

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
