module Domain
  module BTN
    class Episode < SimpleDelegator
      def best_release
        comparable_releases.sort.last
      end

      def download_delay
        return if releases.empty?
        has_killer_release? ? 0 : ENV['DELAY_HOURS'].to_i
      end

      def download_at
        _download_at = __getobj__.download_at
        delay = DateTime.now + download_delay.hours
        return delay unless _download_at.present? && _download_at < delay
        _download_at
      end

      private

      def comparable_releases
        self.releases.map do |release|
          Domain::BTN::ComparableRelease.new(release)
        end
      end

      def has_killer_release?
        best_release.killer?
      end
    end
  end
end
