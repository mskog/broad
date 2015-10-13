module Domain
  module PTP
    class Movie < SimpleDelegator

      def initialize(movie, ptp_api: Services::PTP::Api.new)
        @ptp_api = ptp_api
        super movie
      end

      def has_acceptable_release?(&block)
        acceptable_releases(&block).any?
      end

      def best_release(&block)
        acceptable_releases(&block).sort.last
      end

      def set_attributes
        self.title = ptp_movie.title
        self.imdb_id = "tt#{ptp_movie.imdb_id}"
      end

      def fetch_new_releases
        ptp_movie.releases.each do |ptp_release|
          next if has_release? ptp_release
          release = ::MovieRelease.new(ptp_release.to_h.except(:id).merge(ptp_movie_id: ptp_release.id, auth_key: ptp_movie.auth_key))
          self.association(:releases).add_to_target(release)
        end
      end

      private

      def ptp_movie
        @ptp_movie ||= @ptp_api.search(imdb_id).movie
      end

      def acceptable_releases
        Domain::PTP::AcceptableReleases.new(releases).select do |release|
          if block_given?
            yield release
          else
            true
          end
        end
      end

      def release_ids
        @release_ids ||= self.releases.map(&:ptp_movie_id)
      end

      def has_release?(ptp_release)
        release_ids.include?(ptp_release.id)
      end

      def releases
        @releases ||= self.releases.map do |movie_release|
          Domain::PTP::ComparableRelease.new(Domain::PTP::Release.new(movie_release))
        end
      end
    end
  end
end
