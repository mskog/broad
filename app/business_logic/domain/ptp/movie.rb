module Domain
  module PTP
    class Movie < SimpleDelegator

      def initialize(movie, ptp_api: Services::PTP::Api.new, acceptable_release_rule_klass: Domain::PTP::ReleaseRules::Default)
        @ptp_api = ptp_api
        @acceptable_release_rule_klass = acceptable_release_rule_klass
        super movie
      end

      def has_acceptable_release?(&block)
        acceptable_releases(&block).any?
      end

      def best_release(&block)
        acceptable_releases(&block).sort.last
      end

      def fetch_new_releases
        ptp_movie.releases.each do |ptp_release|
          find_or_initialize_release(ptp_release)
        end
      end

      private

      def ptp_movie
        @ptp_movie ||= @ptp_api.search(imdb_id).movie
      end

      def acceptable_releases
        Domain::PTP::AcceptableReleases.new(releases, rule_klass: @acceptable_release_rule_klass).select do |release|
          block_given? ? (yield release) : true
        end
      end

      def release_ids
        @release_ids ||= self.releases.map(&:ptp_movie_id)
      end

      def find_or_initialize_release(ptp_release)
        release = find_release(ptp_release) || initialize_release(ptp_release)
        release.attributes = ptp_release.to_h.except(:id)
      end

      def find_release(ptp_release)
        release = releases.find do |release|
          release.ptp_movie_id == ptp_release.id
        end
      end

      def initialize_release(ptp_release)
        release = ::MovieRelease.new(ptp_movie_id: ptp_release.id, auth_key: ptp_movie.auth_key)
        self.association(:releases).add_to_target(release)
        release
      end

      def has_release?(ptp_release)
        release_ids.include?(ptp_release.id)
      end

      def releases
        self.releases.map do |movie_release|
          Domain::PTP::ComparableRelease.new(Domain::PTP::Release.new(movie_release))
        end
      end
    end
  end
end
