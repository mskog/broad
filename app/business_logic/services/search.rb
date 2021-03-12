module Services
  class Search
    def initialize
      @search_service = ::Services::Omdb::Api.new
    end

    def by_id(imdb_id)
      @search_service.by_id(imdb_id)
    end

    def movies(query)
      Services::SearchResults::Movies.from_omdb(@search_service.search(query, type: :movie))
    end

    def tv_shows(query)
      Services::SearchResults::TvShows.from_omdb(@search_service.search(query, type: :series))
    end
  end
end
