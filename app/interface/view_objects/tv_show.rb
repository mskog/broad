module ViewObjects
  class TvShow < SimpleDelegator
    def self.from_params(params)
      new(::TvShow.find(params[:id]))
    end

    def initialize(tv_show)
      super Domain::BTN::TvShow.new(tv_show)
    end

    def episodes
      super.order(season: :desc, episode: :desc)
    end

  end
end
