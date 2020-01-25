module Types
  class TraktIdsType < Types::BaseObject
    field :imdb, String, null: true
    field :tmdb, String, null: true
    field :trakt, Integer, null: true
    field :tvdb, String, null: true
    field :tvrage, String, null: true
    field :slug, String, null: true
  end
end
