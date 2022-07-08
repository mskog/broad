# typed: true
module Domain
  module Ptp
    module ReleaseRules
      # TODO: Do we need this?
      class Waitlist < Default
        WAIT_FOR_BLURAY_MONTHS = 12

        def initialize(release)
          @release = release
        end

        def acceptable?
          return true if @release.movie.release_date.present? && @release.movie.release_date < Date.today - WAIT_FOR_BLURAY_MONTHS.to_i.months
          super && mkv_container? && full_hd?
        end

        private

        def bluray?
          @release.source == "blu-ray" && @release.release_name.downcase.exclude?("bdrip")
        end

        def mkv_container?
          @release.container == "mkv"
        end

        def full_hd?
          @release.resolution == "1080p"
        end
      end
    end
  end
end
