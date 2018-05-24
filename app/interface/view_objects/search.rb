module ViewObjects
  class Search < SimpleDelegator
    include Enumerable

    def self.movies(query)
      new(query, search_service: Services::Search.movies)
    end

    def self.tv_shows(query)
      new(query, search_service: Services::Search.tv_shows)
    end

    def initialize(query, search_service:)
      @query = query
      @search_service = search_service
    end

    def to_ary
      to_a
    end

    def each(&block)
      @search_service.search(@query).each(&block)
    end
  end
end
