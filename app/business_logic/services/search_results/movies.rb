module Services
  module SearchResults
    class Movies
      include Enumerable

      def self.from_trakt(results)
        new(results.map{|result| MovieResult.from_trakt(result)})
      end

      def self.from_omdb(results)
        new(Array.wrap(results).map{|result| MovieResult.from_omdb(result)})
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
      attribute :tmdb_id, String
      attribute :imdb_url, String
      attribute :downloaded, Boolean
      attribute :poster, String

      def self.from_trakt(result)
        movie = result
        attributes = {
          title: movie.title,
          year: movie.year,
          overview: movie.overview,
          imdb_id: movie.ids.imdb,
          tmdb_id: movie.ids.tmdb,
          imdb_url: Services::Imdb.new(movie.ids.imdb).url,
          downloaded: Movie.where(imdb_id: movie.ids.imdb).exists?
        }
        new(attributes)
      end

      def self.from_omdb(result)
        movie = result

        attributes = {
          title: result["Title"],
          year: result["Year"],
          imdb_id: result["imdbID"],
          poster: result["Poster"],
          imdb_url: Services::Imdb.new(result["imdbID"]).url,
          downloaded: Movie.where(imdb_id: result["imdbID"]).exists?
        }
        new(attributes)
      end
    end
  end
end
