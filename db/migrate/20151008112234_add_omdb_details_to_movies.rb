class AddOmdbDetailsToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :omdb_details, :hstore
  end
end
