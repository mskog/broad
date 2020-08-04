module Types
  class TraktDetailsType < Types::BaseObject
    field :ids, Types::TraktIdsType, null: true
    field :title, String, null: true
    field :year, Integer, null: true
    field :runtime, Integer, null: true
    field :overview, String, null: true
    field :network, String, null: true
    field :genres, [String], null: true
  end
end
