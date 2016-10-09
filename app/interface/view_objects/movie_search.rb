module ViewObjects
  class MovieSearch < SimpleDelegator
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
      @results ||= Services::MovieSearch.new(@query)
    end

  end
end
