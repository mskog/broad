class Resolvers::ShowCollectionProgress < Resolvers::Base
  type [Types::MovieType], null: false

  argument :id, type: String, required: true

  type Types::ProgressShow, null: false

  def resolve(id:)
    Broad::ServiceRegistry.trakt_user.collected_show(id)
  end
end
