# typed: true
class AddMovieDetailFieldsToMoviesAndMovieRecommendations < ActiveRecord::Migration[5.0]
  def change
    # Movie
    add_column :movies, :trakt_rating, :float
    add_column :movies, :release_date, :date
    add_column :movies, :runtime, :integer
    add_column :movies, :language, :string
    add_column :movies, :genres, :string, array: true
    add_column :movies, :certification, :string
    add_column :movies, :overview, :string
    rename_column :movies, :slug, :trakt_slug

    # Movie Recommendation
    add_column :movie_recommendations, :trakt_rating, :float
    add_column :movie_recommendations, :release_date, :date
    add_column :movie_recommendations, :runtime, :integer
    add_column :movie_recommendations, :language, :string
    add_column :movie_recommendations, :genres, :string, array: true
    add_column :movie_recommendations, :certification, :string
    add_column :movie_recommendations, :overview, :string
    rename_column :movie_recommendations, :slug, :trakt_slug
  end
end
