module Domain
  module PTP
    module ReleaseRules
      class Killer < Default
        def initialize(release)
          @release = release
        end

        def acceptable?
          super && acceptable_source? && mkv_container? && remux?
        end

        private

        def acceptable_source?
          %w[blu-ray hd-dvd].include? @release.source
        end

        def mkv_container?
          @release.container == "mkv"
        end

        def remux?
          @release.version_attributes.include?("remux")
        end
      end
    end
  end
end
