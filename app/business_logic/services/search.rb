module Services
  class Search
    def initialize
      @search_service = ::Services::Omdb::Api.new
    end

    def movies(query)
      Services::SearchResults::Movies.from_omdb(@search_service.search(query, type: :movie))
    end

    def tv_shows(query)
      @search_service.search(query, type: :series)
    end
  end
end
