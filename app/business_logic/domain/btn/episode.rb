module Domain
  module BTN
    class Episode < SimpleDelegator
      def best_release
        @best_release ||= self.releases.map do |release|
          Domain::BTN::ComparableRelease.new(release)
        end.sort.last
      end

      def download_at
        return if releases.empty?
        has_killer_release? ? DateTime.now : DateTime.now + ENV['DELAY_HOURS'].to_i.hours
      end

      private

      def has_killer_release?
        ['web-dl', 'webrip'].include?(best_release.source) && best_release.resolution == '1080p'
      end
    end
  end
end
