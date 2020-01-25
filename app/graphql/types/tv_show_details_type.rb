module Types
  class TvShowDetailsType < Types::BaseObject
    field :title, String, null: true
    field :year, Integer, null: true
    field :overview, String, null: true
    field :first_aired, GraphQL::Types::ISO8601Date, null: true
    field :trailer, String, null: true
    field :homepage, String, null: true
    field :rating, Float, null: true
    field :runtime, Integer, null: true
    field :votes, Integer, null: true
    field :genres, [String], null: true
    field :certification, String, null: true
    field :country, String, null: true
    field :network, String, null: true
    field :status, String, null: true
    field :aired_episodes, Integer, null: true

    field :ids, Types::TraktIdsType, null: true
  end
end
