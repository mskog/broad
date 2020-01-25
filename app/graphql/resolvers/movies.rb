class Resolvers::Movies < Resolvers::Base
  type [Types::MovieType], null: false

  argument :first, type: Integer, required: false
  argument :skip, type: Integer, required: false
  argument :category, type: String, required: false
  argument :query, String, required: false

  def resolve(first: nil, skip: nil, category: nil, query: nil)
    scope = Movie.all
    scope = scope.offset(skip) if skip.present?
    scope = scope.limit(first) if first.present?
    scope = apply_category(scope, category) if category.present?
    scope = scope.where("overview ILIKE :query OR title ILIKE :query", query: "%#{query}%") if query.present?
    MovieDecorator.decorate_collection ViewObjects::Movies.new(scope)
  end

  def apply_category(scope, value)
    if value == "watched"
      scope.watched.order(watched_at: :desc)
    elsif value == "downloads"
      scope.where(watched_at: nil).downloadable.order(Arel.sql("movies.download_at IS NOT NULL desc, movies.download_at desc, movies.id desc"))
    else
      scope.on_waitlist.order(Arel.sql("movies.download_at IS NOT NULL desc, movies.download_at desc, movies.id desc"))
    end
  end
end
