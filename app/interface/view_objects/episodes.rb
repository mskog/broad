module ViewObjects
  class Episodes
    include Enumerable

    def self.from_params(*)
      self.new(::Episode.order(id: :desc))
    end

    def initialize(episodes)
      @episodes = episodes
    end

    def to_ary
      to_a
    end

    def each(&block)
      episodes.each(&block)
    end

    def downloadable
      @episodes = @episodes.where("episodes.published_at < ?", ENV['DELAY_HOURS'].to_i.hours.ago)
      self
    end

    private

    def episodes
      @episodes.map do |episode|
        Domain::BTN::Episode.new(episode)
      end
    end
  end
end
