module Types
  class NewsItemType < Types::BaseObject
    field :id, Integer, null: false
    field :title, String, null: false
    field :url, String, null: false
    field :score, Integer, null: false

    field :metadata, Types::NewsItemMetadataType, null: false

    field :newsworthy, Types::NewsworthyType, null: true
  end
end
