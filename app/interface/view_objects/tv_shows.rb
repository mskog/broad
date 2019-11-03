module ViewObjects
  class TvShows < SimpleDelegator
    include Enumerable
    include ViewObjects::Support::Paginatable

    def self.from_params(*)
      order_clause = Arel.sql("CASE WHEN tv_shows.name ILIKE 'The%' THEN substring(tv_shows.name,4) ELSE tv_shows.name END ASC")
      new(::TvShow.order(Arel.sql("tv_shows.watching = true DESC")).order(order_clause))
    end

    def self.all
      new(::TvShow.all.order(name: :asc))
    end

    def self.watching
      new(::TvShow.watching.order(name: :asc))
    end

    def self.not_watching
      new(::TvShow.not_watching.order(name: :asc))
    end

    def self.ended
      new(::TvShow.ended.order(name: :asc))
    end

    def to_ary
      to_a
    end

    def each
      __getobj__.each do |tv_show|
        yield Domain::BTN::TvShow.new(tv_show)
      end
    end
  end
end
