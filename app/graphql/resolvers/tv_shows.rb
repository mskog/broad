class Resolvers::TvShows < Resolvers::Base
  type [Types::TvShowType], null: false

  argument :first, type: Integer, required: false
  argument :skip, type: Integer, required: false
  argument :category, type: String, required: false
  argument :query, String, required: false

  def resolve(first: nil, skip: nil, category: nil, query: nil)
    scope = TvShow.all
    scope = scope.offset(skip) if skip.present?
    scope = scope.limit(first) if first.present?
    scope = apply_category(scope, category) if category.present?
    scope = scope.where("tv_shows.name ILIKE :query", query: "%#{query}%") if query.present?
    scope
  end

  # TODO: This is bad. We need proper categories I think and not this implicit stuff
  def apply_category(scope, value)
    if value == "waitlist"
      scope.on_waitlist.ordered_by_name
    elsif value == "watching"
      scope.watching.ordered_by_name
    elsif value == "not_watching"
      scope.not_watching.ordered_by_name
    else
      scope.ended.ordered_by_name
    end
  end
end
