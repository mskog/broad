class Episode < ActiveRecord::Base
  has_many :releases
end
