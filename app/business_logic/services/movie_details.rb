module Services
  class MovieDetails
    include Virtus.model

    attribute :title, String
    attribute :imdb_id, String
    attribute :tmdb_id, Integer
    attribute :trakt_id, Integer
    attribute :trakt_rating, Float
    attribute :trakt_slug, String
    attribute :release_date, Date
    attribute :runtime, Integer
    attribute :language, String
    attribute :genres, Array
    attribute :certification, String
    attribute :overview, String

    def self.from_trakt(movie_extended)
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
        overview: movie_extended.overview,
      }
      new attributes
    end
  end
end
