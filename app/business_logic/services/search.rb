module Services
  # TODO: Specs for no results
  class Search
    include Enumerable

    def self.movies
      new
    end

    def self.tv_shows
      new(search_type: :show, results_klass: SearchResults::TvShows)
    end

    def initialize(search_type: :movie, results_klass: SearchResults::Movies, search_service: ::Broad::ServiceRegistry.trakt_search)
      @search_type = search_type
      @results_klass = results_klass
      @search_service = search_service
    end

    def search(query)
      mapped_query = Query.new(query)

      if mapped_query.imdb_id.present?
        @results_klass.from_trakt(@search_service.id(mapped_query.imdb_id, type: @search_type))
      else
        @results_klass.from_trakt(@search_service.send(@search_type.to_s.pluralize, mapped_query.query))
      end
    end
  end
end
