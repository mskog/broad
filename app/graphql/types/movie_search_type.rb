module Types
  class MovieSearchType < Types::BaseObject
    field :title, String, null: true
    field :year, Integer, null: true
    field :overview, String, null: true
    field :imdb_id, String, null: true
    field :tmdb_id, String, null: true
    field :imdb_url, String, null: true
    field :downloaded, Boolean, null: true
    field :has_acceptable_release, Boolean, null: false
    field :has_killer_release, Boolean, null: false

    field :releases, [Types::MovieReleaseType], null: true
    field :best_release, Types::MovieReleaseType, null: true

    def has_killer_release
      domain_object.has_killer_release?
    end

    def has_acceptable_release
      domain_object.has_acceptable_release?
    end

    def releases
      domain_object.fetch_new_releases
      domain_object.acceptable_releases
    end

    def best_release
      domain_object.fetch_new_releases
      domain_object.best_release
    end

    def domain_object
      @domain_object ||= begin
        movie = Domain::PTP::Movie.new(Movie.new(imdb_id: object.imdb_id))
        movie.fetch_new_releases
        MovieDecorator.new(movie)
      end
    end
  end
end
