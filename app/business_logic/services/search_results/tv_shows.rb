module Services
  module SearchResults
    class TvShows
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

    class TvShowResult < Dry::Struct
      transform_keys do |key|
        key.to_s.underscore.downcase.to_sym
      end

      attribute :title, Types::String.optional
      attribute :year, Types::Integer.optional
      attribute? :overview, Types::String.optional
      attribute :imdb_id, Types::String.optional
      attribute :tmdb_id, Types::Integer.optional
      attribute :tvdb_id, Types::Integer.optional
      attribute :imdb_url, Types::String.optional
      attribute :exists, Types::Bool
      attribute :existing_tv_show_id, Types::Integer.optional

      def self.from_trakt(result)
        tv_show = result
        existing_tv_show = TvShow.find_by(imdb_id: tv_show.ids.imdb)

        attributes = {
          title: tv_show.title,
          year: tv_show.year,
          overview: tv_show.overview,
          imdb_id: tv_show.ids.imdb,
          tmdb_id: tv_show.ids.tmdb,
          tvdb_id: tv_show.ids.tvdb,
          imdb_url: Services::Imdb.new(tv_show.ids.imdb).url,
          exists: existing_tv_show.present?,
          existing_tv_show_id: existing_tv_show&.id
        }
        new(attributes)
      end
    end
  end
end
