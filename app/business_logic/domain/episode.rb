module Domain
  class Episode < SimpleDelegator
    def best_release
      @best_release ||= self.releases.map do |release|
        Domain::ComparableRelease.new(release)
      end.sort.last
    end
  end
end
