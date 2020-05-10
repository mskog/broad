module Types
  class MovieSummaryType < Types::BaseObject
    field :title, String, null: true
    field :year, Integer, null: true
    field :overview, String, null: true
    field :rating, String, null: true
    field :status, String, null: true
    field :runtime, Integer, null: true
    field :released, GraphQL::Types::ISO8601Date, null: true
  end
end
