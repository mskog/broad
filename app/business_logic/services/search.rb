module Services

  # TODO Specs for no results
  class Search
    include Enumerable

    def self.movies(query)
      new(query)
    end

    def self.tv_shows(query)
      new(query, search_type: :show, results_klass: SearchResults::TvShows)
    end

    def initialize(query, search_type: :movie, results_klass: SearchResults::Movies, search_service: ::Broad::ServiceRegistry.trakt_search)
      @query = Query.new(query)
      @search_type = search_type
      @results_klass = results_klass
      @search_service = search_service
    end

    def each(&block)
      results.each(&block)
    end

    private

    def results
      @results ||= search
    end

    def search
      if @query.imdb_id.present?
        @results_klass.from_trakt(@search_service.id(@query.imdb_id, type: @search_type))
      else
        @results_klass.from_trakt(@search_service.send(@search_type.to_s.pluralize, @query.query))
      end
    end
  end
end
