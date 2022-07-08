# typed: true
module Types
  class EpisodeType < Types::BaseObject
    field :id, Integer, null: false
    field :name, String, null: true
    field :season_number, Integer, null: true
    field :episode, Integer, null: true
    field :year, Integer, null: true
    field :published_at, GraphQL::Types::ISO8601DateTime, null: true
    field :key, String, null: true
    field :downloaded, Boolean, null: false
    field :download_at, GraphQL::Types::ISO8601DateTime, null: true
    field :watched, Boolean, null: false
    field :watched_at, GraphQL::Types::ISO8601DateTime, null: true
    field :air_date, GraphQL::Types::ISO8601Date, null: true
    field :aired, Boolean, null: false

    field :still_image, String, null: true
    field :still_image_thumbnail, String, null: true
    field :still_image_base64, String, null: true

    field :tv_show, Types::TvShowType, null: false
    field :tmdb_details, EpisodeTmdbDetailsType, null: true
    field :best_release, Types::EpisodeReleaseType, null: true

    def still_image_thumbnail
      object.still_image("w300")
    end

    def aired
      object.aired?
    end
  end
end
