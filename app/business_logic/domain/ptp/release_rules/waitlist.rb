module Domain
  module PTP
    module ReleaseRules
      class Waitlist
        def initialize(release)
          @release = release
        end

        def acceptable?
          !@release.version_attributes.include?("3d") && @release.source == 'blu-ray'
        end
      end
    end
  end
end
