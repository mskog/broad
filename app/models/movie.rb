class Movie < ActiveRecord::Base
  has_many :movie_releases, dependent: :destroy
end
