# typed: true
class AddRtCriticsRatingToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :rt_critics_rating, :integer
  end
end
