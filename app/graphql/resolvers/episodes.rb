class Resolvers::Episodes < Resolvers::Base
  type [Types::EpisodeType], null: false

  argument :first, type: Integer, required: false
  argument :skip, type: Integer, required: false
  argument :category, type: Types::EpisodeCategory, required: false

  def resolve(first: nil, skip: nil, category: "DOWNLOADS")
    scope = ::Episode.includes(:tv_show).with_release
    scope = scope.offset(skip) if skip.present?
    scope = scope.limit(first) if first.present?

    if category == "WATCHED"
      scope.watched.order("watched_at desc NULLS LAST")
    else
      scope.order("download_at desc NULLS LAST, air_date desc NULLS LAST")
    end
  end
end
