module Domain
  module PTP
    class Movie < SimpleDelegator

      def best_release
        releases = movie_releases.map do |movie_release|
          Domain::PTP::ComparableRelease.new(movie_release)
        end

        Domain::PTP::AcceptableReleases.new(releases).sort.last
      end
    end
  end
end
