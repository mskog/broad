module Services
  module SearchResults
    class Movies
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

    class MovieResult < Dry::Struct
      transform_keys do |key|
        key.to_s.underscore.downcase.to_sym
      end

      attribute :title, Types::String
      attribute :year, Types::Integer
      attribute :overview, Types::String
      attribute :imdb_id, Types::String
      attribute :tmdb_id, Types::Integer
      attribute :imdb_url, Types::String
      attribute :downloaded, Types::Bool
      attribute :on_waitlist, Types::Bool
      attribute :existing_movie_id, Types::Integer.optional

      def self.from_trakt(result)
        movie = result
        existing_movie = Movie.find_by(imdb_id: movie.ids.imdb)

        attributes = {
          title: movie.title,
          year: movie.year,
          overview: movie.overview,
          imdb_id: movie.ids.imdb,
          tmdb_id: movie.ids.tmdb,
          imdb_url: Services::Imdb.new(movie.ids.imdb).url,
          downloaded: existing_movie&.download_at.present?,
          on_waitlist: existing_movie&.waitlist.present?,
          existing_movie_id: existing_movie&.id

        }
        new(attributes)
      end
    end
  end
end
