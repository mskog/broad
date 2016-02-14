module Services
  class MovieSearch
    include Enumerable

    def initialize(query)
      @query = query
    end

    def each(&block)
      results.each(&block)
    end

    private

    def results
      @results ||= MovieResults.from_trakt(Services::Trakt::Search.new.movies(@query))
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

      def self.from_trakt(result)
        movie = result['movie']
        attributes = {
          title: movie['title'],
          year: movie['year'],
          overview: movie['overview'],
          imdb_id: movie['ids']['imdb'],
          imdb_url: Services::Imdb.new(movie['ids']['imdb']).url
        }
        new(attributes)
      end
    end
  end
end
