module Types
  class TvShowSummaryType < Types::BaseObject
    field :title, String, null: true
    field :year, Integer, null: true
    field :overview, String, null: true
    field :rating, String, null: true
    field :status, String, null: true
    field :runtime, Integer, null: true
    field :aired_episodes, Integer, null: true
    field :first_aired, GraphQL::Types::ISO8601Date, null: true
    field :country, String, null: true
    field :network, String, null: true
    field :genres, [String], null: true
  end
end
