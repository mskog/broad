module Domain
  module PTP
    module ReleaseRules
      class Killer < Default
        def initialize(release)
          @release = release
        end

        def acceptable?
          super && bluray? && mkv_container? && remux?
        end

        private

        def bluray?
          @release.source == 'blu-ray'
        end

        def mkv_container?
          @release.container == 'mkv'
        end

        def remux?
          @release.version_attributes.include?('remux')
        end
      end
    end
  end
end
