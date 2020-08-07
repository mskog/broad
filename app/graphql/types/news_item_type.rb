module Types
  class NewsItemType < Types::BaseObject
    field :id, Integer, null: true
    field :title, String, null: true
    field :url, String, null: true
    field :score, Integer, null: true
  end
end
