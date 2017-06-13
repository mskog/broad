class AddTraktDetailsToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :trakt_details, :hstore
    add_column :movie_recommendations, :trakt_details, :hstore
  end
end
