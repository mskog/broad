module ViewObjects
  class TvShow < SimpleDelegator
    def self.from_params(params)
      new(::TvShow.find(params[:id]))
    end

    def initialize(tv_show)
      super Domain::BTN::TvShow.new(tv_show)
    end

    def episodes
      ::ViewObjects::Episodes.new(super.order(season: :desc, episode: :desc))
    end

    def released_episodes
      ::ViewObjects::Episodes.new(__getobj__.episodes.order(season: :desc, episode: :desc)).with_release
    end

    def aired_episodes
      episodes.aired
    end
  end
end
