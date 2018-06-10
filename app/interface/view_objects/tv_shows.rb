module ViewObjects
  class TvShows < SimpleDelegator
    include Enumerable
    include ViewObjects::Support::Paginatable

    def self.from_params(*)
      new(::TvShow.order(Arel.sql("tv_shows.watching = true DESC")).order(name: :asc))
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
