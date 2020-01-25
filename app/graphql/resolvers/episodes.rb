class Resolvers::Episodes < Resolvers::Base
  type [Types::EpisodeType], null: false

  argument :first, type: Integer, required: false
  argument :skip, type: Integer, required: false

  def resolve(first: nil, skip: nil)
    scope = Episode.includes(:tv_show).with_release
    scope = scope.offset(skip) if skip.present?
    scope = scope.limit(first) if first.present?
    scope = scope.order(id: :desc)
    EpisodeDecorator.decorate_collection ViewObjects::Episodes.new(scope)
  end
end
