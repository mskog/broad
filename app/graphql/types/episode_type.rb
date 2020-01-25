module Types
  class EpisodeType < Types::BaseObject
    field :id, Integer, null: true
    field :name, String, null: true
    field :season, Integer, null: true
    field :episode, Integer, null: true
    field :year, Integer, null: true
    field :published_at, GraphQL::Types::ISO8601DateTime, null: true
    field :key, String, null: true
    field :download_at, GraphQL::Types::ISO8601DateTime, null: true
    field :watched, Boolean, null: true
    field :first_aired, GraphQL::Types::ISO8601Date, null: true

    field :still, String, null: true

    field :tv_show, Types::TvShowType, null: false
    field :tmdb_details, EpisodeTmdbDetailsType, null: true
  end
end