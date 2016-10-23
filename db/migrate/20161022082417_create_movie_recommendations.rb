class CreateMovieRecommendations < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_recommendations do |t|
      t.string :title
      t.integer :year
      t.string :imdb_id, index: true, unique: true
      t.string :trakt_id, index: true, unique: true
      t.string :tmdb_id, index: true, unique: true
      t.string :slug
      t.timestamps
    end
  end
end
