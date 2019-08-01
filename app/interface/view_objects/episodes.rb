module ViewObjects
  class Episodes < SimpleDelegator
    include Enumerable
    include ViewObjects::Support::Paginatable

    def self.from_params(*)
      new(::Episode.eager_load(:releases).order(id: :desc))
    end

    def self.from_tv_show_id(tv_show_id)
      new(::TvShow.find(tv_show_id).episodes)
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

    def with_distinct_releases
      __setobj__(__getobj__.where("episodes.id IN (SELECT distinct on (episode_releases.url) episode_releases.episode_id FROM episode_releases ORDER BY episode_releases.url, episode_releases.episode_id)"))
      self
    end

    def limit(number)
      __setobj__(__getobj__.limit(number))
      self
    end

    def downloadable
      __setobj__(__getobj__.downloadable)
      self
    end
  end
end
