# typed: true
class AddOmdbDetailsToMovieRecommendation < ActiveRecord::Migration[5.0]
  def change
    add_column :movie_recommendations, :omdb_details, :hstore
  end
end
