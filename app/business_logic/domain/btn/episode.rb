module Domain
  module Btn
    class Episode < SimpleDelegator
      def best_release
        comparable_releases.sort.reverse.first
      end

      # TODO: will return nil if no release exists
      def best_available_release
        comparable_releases.sort.reverse.first
      end

      def download
        release = best_available_release
        return if release.blank?
        best_available_release.update downloaded: true
        best_available_release.url
      end

      def download_delay
        return nil if releases.empty?
        has_killer_release? || !releasing_in_4k? ? 0 : ENV["DELAY_HOURS"].to_i
      end

      def download_at
        return nil if releases.empty?

        downloaded_release = comparable_releases.sort.reverse.find(&:downloaded?)
        better_available = !watched? && downloaded_release.try(:resolution_points).to_i < best_release.resolution_points

        download = better_available ? Time.now : __getobj__.download_at
        delay = DateTime.now + download_delay.hours
        return delay unless download.present? && download < delay
        download
      end

      private

      def comparable_releases
        __getobj__.releases.map do |release|
          Domain::Btn::Release.new(release)
        end
      end

      def has_killer_release?
        best_release.killer?
      end

      def releasing_in_4k?
        return true unless tv_show.episodes.size > 1

        tv_show.episodes.any? do |episode|
          Domain::Btn::Episode.new(episode).best_available_release.try(:resolution) == "2160p"
        end
      end
    end
  end
end
