class RemoveMovieRecommendations < ActiveRecord::Migration[6.1]
  def change
    drop_table :movie_recommendations
  end
end
