# typed: strict
module Types
  class NewsItemType < Types::BaseObject
    field :id, Integer, null: false
    field :title, String, null: false
    field :url, String, null: false
    field :score, Integer, null: false

    field :metadata, Types::NewsItemMetadataType, null: true

    field :newsworthy, Types::NewsworthyType, null: true
  end
end
