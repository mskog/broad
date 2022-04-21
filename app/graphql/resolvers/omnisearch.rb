class Resolvers::Omnisearch < Resolvers::Base
  argument :query, String, "The search query", required: true

  type [Types::OmnisearchResultType], null: false

  def resolve(query:)
    PgSearch.multisearch(query).includes(:searchable).map(&:searchable)
  end
end
