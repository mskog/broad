class Resolvers::Episodes < Resolvers::Base
  type [Types::EpisodeType], null: false

  argument :first, type: Integer, required: false
  argument :skip, type: Integer, required: false
  argument :category, type: Types::EpisodeCategory, required: false

  def resolve(first: nil, skip: nil, category: "DOWNLOADS")
    scope = Episode.includes(:tv_show).with_release
    scope = scope.offset(skip) if skip.present?
    scope = scope.limit(first) if first.present?

    scope = if category == "WATCHED"
              scope.watched.order("watched_at desc NULLS LAST")
            else
              scope.order(id: :desc)
            end

    EpisodeDecorator.decorate_collection ViewObjects::Episodes.new(scope)
  end
end
