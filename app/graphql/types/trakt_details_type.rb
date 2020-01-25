module Types
  class TraktDetailsType < Types::BaseObject
    field :ids, Types::TraktIdsType, null: true
    field :title, String, null: true
    field :year, Integer, null: true
    field :overview, String, null: true
  end
end
