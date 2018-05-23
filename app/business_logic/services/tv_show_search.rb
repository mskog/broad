module Services

  # TODO Functional but sucks. Refactor into something less bad
  # TODO Specs for no results
  class TvShowSearch
    include Enumerable

    def initialize(query, search_service: ::Broad::ServiceRegistry.trakt_search)
      @query = Query.new(query)
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
        TvShowResults.from_trakt(@search_service.id(@query.imdb_id, type: :show))
      else
        TvShowResults.from_trakt(@search_service.shows(@query.query))
      end
    end

    class TvShowResults
      include Enumerable

      def self.from_trakt(results)
        new(results.map{|result| TvShowResult.from_trakt(result)})
      end

      def initialize(results)
        @results = results
      end

      def each(&block)
        @results.each(&block)
      end
    end

    class TvShowResult
      include Virtus.model

      attribute :title, String
      attribute :year, Integer
      attribute :overview, String
      attribute :imdb_id, String
      attribute :tmdb_id, String
      attribute :tvdb_id, String
      attribute :imdb_url, String
      attribute :downloaded, Boolean

      def self.from_trakt(result)
        tv_show = result
        attributes = {
          title: tv_show.title,
          year: tv_show.year,
          overview: tv_show.overview,
          imdb_id: tv_show.ids.imdb,
          tmdb_id: tv_show.ids.tmdb,
          tvdb_id: tv_show.ids.tvdb,
          imdb_url: Services::Imdb.new(tv_show.ids.imdb).url,
          downloaded: Movie.where(imdb_id: tv_show.ids.imdb).exists?
        }
        new(attributes)
      end
    end
  end
end
