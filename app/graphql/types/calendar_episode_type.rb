module Types
  class CalendarEpisodeType < Types::BaseObject
    field :id, Integer, null: true
    field :name, String, null: true
    field :title, String, null: true
    field :season, Integer, null: true
    field :number, Integer, null: true
    field :first_aired, GraphQL::Types::ISO8601Date, null: true

    field :ids, Types::TraktIdsType, null: true
    field :tmdb_details, Types::EpisodeTmdbDetailsType, null: true
  end
end
