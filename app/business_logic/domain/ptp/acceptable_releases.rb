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
          release.seeders > 0
        end
      end
    end
  end
end
