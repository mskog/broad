class NewsItem < ActiveRecord::Base
  belongs_to :newsworthy, polymorphic: true
end
