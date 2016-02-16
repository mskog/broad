module Services
  class MovieSearch
    include Enumerable

    def initialize(query, search_service: Services::Trakt::Search.new)
      @query = query
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
      if Services::Imdb.matches?(@query)
        MovieResults.from_trakt(@search_service.id(Services::Imdb.from_data(@query).id))
      else
        MovieResults.from_trakt(@search_service.movies(@query))
      end
    end

    class MovieResults
      include Enumerable

      def self.from_trakt(results)
        new(results.map{|result| MovieResult.from_trakt(result)})
      end

      def initialize(results)
        @results = results
      end

      def each(&block)
        @results.each(&block)
      end

    end

    class MovieResult
      include Virtus.model

      attribute :title, String
      attribute :year, Integer
      attribute :overview, String
      attribute :imdb_id, String
      attribute :imdb_url, String
      attribute :poster, String

      def self.from_trakt(result)
        movie = result['movie']
        attributes = {
          title: movie['title'],
          year: movie['year'],
          overview: movie['overview'],
          imdb_id: movie['ids']['imdb'],
          imdb_url: Services::Imdb.new(movie['ids']['imdb']).url,
          poster: movie['images']['poster']['thumb']
        }
        new(attributes)
      end
    end
  end
end
