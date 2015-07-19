module Domain
  class Episode
    def initialize(episode)
      @episode = episode
    end

    def best_release
      @best_release ||= @episode.releases.map do |release|
        Domain::ComparableRelease.new(release)
      end.sort.last
    end
  end
end
