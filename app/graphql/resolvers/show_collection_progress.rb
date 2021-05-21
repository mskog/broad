class Resolvers::ShowCollectionProgress < Resolvers::Base
  type [Types::MovieType], null: false

  argument :id, type: ID, required: true

  type Types::ProgressShow, null: false

  def resolve(id:)
    show = TvShow.find(id)
    Broad::ServiceRegistry.trakt_user.collected_show(show.imdb_id)
  end
end
