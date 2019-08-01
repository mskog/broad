module Domain
  module BTN
    class Episode < SimpleDelegator
      def best_release
        comparable_releases.sort.reverse.first
      end

      # TODO: will return nil if no release exists
      def best_available_release
        comparable_releases.sort.reverse.find(&:exists?)
      end

      def download_delay
        return nil if releases.empty?
        has_killer_release? ? 0 : ENV["DELAY_HOURS"].to_i
      end

      def download_at
        return nil if releases.empty?
        download = __getobj__.download_at
        delay = DateTime.now + download_delay.hours
        return delay unless download.present? && download < delay
        download
      end

      private

      def comparable_releases
        __getobj__.releases.map do |release|
          Domain::BTN::Release.new(release)
        end
      end

      def has_killer_release?
        best_release.killer?
      end
    end
  end
end
