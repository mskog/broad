# typed: false
module Services
  # TODO: Is this necessary? Can't we just use the mapped data from the Trakt api directly?
  class MovieDetails < Dry::Struct
    transform_keys(&:to_sym)

    attribute :title, Types::String.optional
    attribute :imdb_id, Types::String.optional
    attribute :tmdb_id, Types::Integer.optional
    attribute :trakt_id, Types::Integer.optional
    attribute :trakt_rating, Types::Float.optional
    attribute :trakt_slug, Types::String.optional
    attribute :release_date, Types::JSON::Date.optional
    attribute :runtime, Types::Integer.optional
    attribute :language, Types::String.optional
    attribute :genres, Types::Array.of(Types::String).optional
    attribute :certification, Types::String.optional
    attribute :overview, Types::String.optional

    def self.from_trakt(movie_extended)
      return nil if movie_extended.blank?
      attributes = {
        title: movie_extended.title,
        imdb_id: movie_extended.ids.imdb,
        tmdb_id: movie_extended.ids.tmdb,
        trakt_id: movie_extended.ids.trakt,
        trakt_slug: movie_extended.ids.slug,
        trakt_rating: movie_extended.rating,
        release_date: movie_extended.released,
        runtime: movie_extended.runtime,
        language: movie_extended.language,
        genres: movie_extended.genres,
        certification: movie_extended.certification,
        overview: movie_extended.overview
      }
      new attributes
    end

    def has_data?
      title.present?
    end
  end
end
