module Domain
  module PTP
    class AcceptableReleases
      include Enumerable

      def initialize(releases)
        @releases = releases
      end

      def each(&block)
        acceptable_releases.each(&block)
      end

      private

      def acceptable_releases
        @releases.select do |release|
          AcceptableRelease.new(release).acceptable?
        end
      end

      class AcceptableRelease
        def initialize(release)
          @release = release
        end

        def acceptable?
          @release.seeders > 0 && !@release.version_attributes.include?("3d") && @release.source != 'ts'
        end
      end
    end
  end
end
