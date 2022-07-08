# typed: true
class RemoveDetailsFieldsFromMovies < ActiveRecord::Migration[5.0]
  def change
    remove_column :movies, :omdb_details
    remove_column :movies, :trakt_details

    remove_column :movie_recommendations, :omdb_details
    remove_column :movie_recommendations, :trakt_details
  end
end
