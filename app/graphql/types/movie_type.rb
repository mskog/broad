module Types
  class MovieType < Types::BaseObject
    include Rails.application.routes.url_helpers

    field :id, Integer, null: false
    field :title, String, null: true
    field :imdb_id, String, null: true
    field :key, String, null: true
    field :waitlist, Boolean, null: true
    field :watched, Boolean, null: true
    field :download_at, GraphQL::Types::ISO8601DateTime, null: true
    field :tmdb_id, String, null: true
    field :trakt_id, String, null: true
    field :trakt_slug, String, null: true
    field :trakt_rating, Float, null: true
    field :release_date, GraphQL::Types::ISO8601Date, null: true
    field :runtime, Integer, null: true
    field :language, String, null: true
    field :genres, [String], null: true
    field :certification, String, null: true
    field :overview, String, null: true
    field :watched_at, GraphQL::Types::ISO8601DateTime, null: true
    field :rt_critics_rating, Integer, null: true
    field :personal_rating, Integer, null: true
    field :rt_audience_rating, Integer, null: true
    field :has_acceptable_release, Boolean, null: false
    field :has_killer_release, Boolean, null: false

    field :poster_image, String, null: true
    field :backdrop_image, String, null: true

    field :cache_key, String, null: false
    field :imdb_url, String, null: false

    field :releases, [Types::MovieReleaseType], null: true
    field :best_release, Types::MovieReleaseType, null: true

    def has_killer_release
      domain_object.has_killer_release?
    end

    def has_acceptable_release
      domain_object.has_acceptable_release?
    end

    def releases
      domain_object.acceptable_releases
    end

    def best_release
      domain_object.best_release
    end

    def domain_object
      @domain_object ||= begin
        movie = Domain::PTP::Movie.new(object)
        MovieDecorator.new(movie)
      end
    end

    def poster_image
      return nil unless domain_object.poster_image.attached?
      rails_blob_url(domain_object.poster_image)
    end

    def backdrop_image
      return nil unless domain_object.backdrop_image.attached?
      rails_blob_url(domain_object.backdrop_image)
    end
  end
end
