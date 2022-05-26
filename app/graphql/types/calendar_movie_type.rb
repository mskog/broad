module Types
  class CalendarMovieType < Types::BaseObject
    field :release_type, String, null: false
    field :release_date, GraphQL::Types::ISO8601DateTime, null: false

    field :movie, Types::MovieType, null: false
  end
end
