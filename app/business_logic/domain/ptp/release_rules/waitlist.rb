module Domain
  module PTP
    module ReleaseRules
      class Waitlist < Default
        def initialize(release)
          @release = release
        end

        def acceptable?
          super && bluray? && mkv_container? && full_hd?
        end

        private

        def bluray?
          @release.source == 'blu-ray' && !@release.release_name.downcase.include?('bdrip')
        end

        def mkv_container?
          @release.container == 'mkv'
        end

        def full_hd?
          @release.resolution == '1080p'
        end
      end
    end
  end
end
