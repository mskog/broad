module Domain
  module BTN
    class Episode < SimpleDelegator
      def best_release
        @best_release ||= self.releases.map do |release|
          Domain::BTN::ComparableRelease.new(release)
        end.sort.last
      end
    end
  end
end
