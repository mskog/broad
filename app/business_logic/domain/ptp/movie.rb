module Domain
  module Ptp
    class Movie < SimpleDelegator
      def initialize(movie, ptp_api: Services::Ptp::Api.new, acceptable_release_rule_klass: Domain::Ptp::ReleaseRules::Default, killer_release_rule_klass: Domain::Ptp::ReleaseRules::Killer)
        @acceptable_release_rule_klass = acceptable_release_rule_klass
        @killer_release_rule_klass = killer_release_rule_klass
        super movie
      end

      def download
        release = best_release
        return if release.blank?
        best_release.update downloaded: true
        best_release.download_url
      end

      def has_better_release_than_downloaded?
        downloaded_release = best_release(&:downloaded?)
        return true if downloaded_release.blank? && acceptable_releases.any?
        better_source = downloaded_release.try(:source_points).to_i < best_release.try(:source_points).to_i
        better_resolution = downloaded_release.try(:resolution_points).to_i < best_release.try(:resolution_points).to_i
        equal_resolution = downloaded_release.try(:resolution_points).to_i <= best_release.try(:resolution_points).to_i

        better_resolution || (equal_resolution && better_source)
      end

      def fetch_new_releases
        return if ptp_movie.blank?
        ptp_movie_releases = ptp_movie.releases

        ptp_movie_releases.each do |ptp_release|
          find_or_initialize_release(ptp_release)
        end

        association(:releases).target = __getobj__.releases.select do |release|
          ptp_movie_releases.map(&:id).include?(release.ptp_movie_id)
        end
      end

      def find_or_initialize_release(ptp_release)
        release = find_release(ptp_release) || initialize_release(ptp_release)
        release.attributes = ptp_release.to_h.except(:id)
      end

      def find_release(ptp_release)
        releases.find do |release|
          release.ptp_movie_id == ptp_release.id
        end
      end

      def initialize_release(ptp_release)
        release = ::MovieRelease.new(ptp_movie_id: ptp_release.id, auth_key: ptp_movie.auth_key)
        association(:releases).add_to_target(release)
        release
      end
    end
  end
end
