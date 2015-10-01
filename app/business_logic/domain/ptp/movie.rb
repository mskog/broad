module Domain
  module PTP
    class Movie < SimpleDelegator

      def best_release
        Domain::PTP::AcceptableReleases.new(releases).sort.last
      end

      private

      def releases
        @releases ||= movie_releases.map do |movie_release|
          Domain::PTP::ComparableRelease.new(movie_release)
        end
      end
    end
  end
end
