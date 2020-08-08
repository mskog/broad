module Types
  class NewsItemType < Types::BaseObject
    field :id, Integer, null: true
    field :title, String, null: true
    field :url, String, null: true
    field :score, Integer, null: true

    field :metadata, Types::NewsItemMetadataType, null: true

    field :newsworthy, Types::NewsworthyType, null: true
  end
end
