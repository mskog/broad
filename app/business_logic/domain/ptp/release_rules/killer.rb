# typed: true
module Domain
  module Ptp
    module ReleaseRules
      class Killer < Default
        def initialize(release)
          @release = release
        end

        def acceptable?
          super && mkv_container? && bluray_or_4k?
        end

        private

        def bluray_or_4k?
          resolution_4k? || (acceptable_source? && remux?)
        end

        def acceptable_source?
          %w[blu-ray hd-dvd].include? @release.source
        end

        def mkv_container?
          @release.container == "mkv"
        end

        def remux?
          @release.remaster_title.to_s.include?("remux")
        end

        def resolution_4k?
          @release.resolution == "2160p"
        end
      end
    end
  end
end
