module Types
  class EpisodeType < Types::BaseObject
    field :id, Integer, null: true
    field :name, String, null: true
    field :season, Integer, null: true, method: :season_number
    field :episode, Integer, null: true
    field :year, Integer, null: true
    field :published_at, GraphQL::Types::ISO8601DateTime, null: true
    field :key, String, null: true
    field :download_at, GraphQL::Types::ISO8601DateTime, null: true
    field :watched, Boolean, null: true
    field :watched_at, GraphQL::Types::ISO8601DateTime, null: true
    field :first_aired, GraphQL::Types::ISO8601Date, null: true

    field :still_image, String, null: true
    field :still_image_thumbnail, String, null: true
    field :still_image_base64, String, null: true

    field :tv_show, Types::TvShowType, null: false
    field :tmdb_details, EpisodeTmdbDetailsType, null: true
    field :best_release, EpisodeReleaseType, null: true

    def still_image_thumbnail
      object.still_image("w300")
    end

    def best_release
      object.best_release.__getobj__
    end
  end
end
