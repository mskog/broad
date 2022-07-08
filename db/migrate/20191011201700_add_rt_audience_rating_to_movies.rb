# typed: true
class AddRtAudienceRatingToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :rt_audience_rating, :integer
  end
end
