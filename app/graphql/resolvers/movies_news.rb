class Resolvers::MoviesNews < Resolvers::Base
  type [Types::NewsItemType], null: false

  def resolve
    NewsItem.where(newsworthy_type: nil).order(score: :desc).limit(25)
  end
end
