module Services
  module SearchResults
    class TvShows
      include Enumerable

      def self.from_trakt(results)
        new(results.map{ |result| TvShowResult.from_trakt(result)})
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
