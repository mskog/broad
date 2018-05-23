module ViewObjects
  class TvShowSearch < SimpleDelegator
    include Enumerable

    def initialize(query)
      @query = query
    end

    def to_ary
      to_a
    end

    def each(&block)
      results.each(&block)
    end

    private

    def results
      @results ||= Services::Search.tv_shows(@query)
    end

  end
end
