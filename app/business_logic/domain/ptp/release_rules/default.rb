module Domain
  module PTP
    module ReleaseRules
      # TODO specs
      class Default
        def initialize(release)
          @release = release
        end

        def acceptable?
          @release.seeders > 0 && !@release.version_attributes.include?("3d") && !['ts', 'cam'].include?(@release.source)
        end
      end
    end
  end
end
