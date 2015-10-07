module Domain
  module PTP
    class Movie < SimpleDelegator

      def best_release
        Domain::PTP::AcceptableReleases.new(releases).sort.last
      end

      def set_attributes(ptp_movie)
        self.title = ptp_movie.title
        self.imdb_id = "tt#{ptp_movie.imdb_id}"
      end

      def fetch_new_releases(ptp_movie)
        ptp_movie.releases.each do |ptp_release|
          release = ::MovieRelease.new(ptp_release.to_h.except(:id, :width, :height).merge(ptp_movie_id: ptp_release.id, auth_key: ptp_movie.auth_key))
          self.association(:movie_releases).add_to_target(release)
        end
      end

      private

      def releases
        @releases ||= movie_releases.map do |movie_release|
          Domain::PTP::ComparableRelease.new(Domain::PTP::Release.new(movie_release))
        end
      end
    end
  end
end
