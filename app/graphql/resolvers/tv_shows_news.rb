class Resolvers::TvShowsNews < Resolvers::Base
  type [Types::NewsItemType], null: false

  def resolve
    NewsItem.where(newsworthy_type: "TvShow").order(score: :desc).limit(25)
  end
end
