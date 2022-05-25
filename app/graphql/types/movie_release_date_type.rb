module Types
  class MovieReleaseDateType < Types::BaseObject
    field :release_type, String, null: false
    field :release_date, GraphQL::Types::ISO8601DateTime, null: false
  end
end
