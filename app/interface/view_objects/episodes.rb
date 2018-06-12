module ViewObjects
  class Episodes < SimpleDelegator
    include Enumerable
    include ViewObjects::Support::Paginatable

    def self.from_params(*)
      self.new(::Episode.eager_load(:releases).order(id: :desc))
    end

    def to_ary
      to_a
    end

    def each
      __getobj__.each do |episode|
        yield Domain::BTN::Episode.new(episode)
      end
    end

    def with_release
      __setobj__(__getobj__.with_release)
      self
    end

    def downloadable
      __setobj__(__getobj__.downloadable)
      self
    end
  end
end
