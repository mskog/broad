class Resolvers::News < Resolvers::Base
  argument :category, String, required: true

  type [Types::NewsItemType], null: false

  def resolve(category:)
    if category == "our_tv_shows"
      NewsItem
        .where(category: "tv_shows")
        .where(newsworthy_type: "TvShow")
        .where("created_at >= ?", 1.month.ago)
        .order(id: :desc)
        .limit(25)
    elsif category == "tv_shows"
      NewsItem
        .where(category: "tv_shows", newsworthy: nil)
        .where("created_at >= ?", 1.month.ago)
        .where("score > 1000")
        .order(id: :desc)
        .limit(25)
    elsif category == "movies"
      NewsItem
        .where(category: "movies")
        .where("created_at >= ?", 1.month.ago)
        .where("score > 1000")
        .order(id: :desc)
        .limit(25)
    end
  end
end
