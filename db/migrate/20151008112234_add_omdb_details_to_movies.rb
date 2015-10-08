class AddOmdbDetailsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :omdb_details, :hstore
  end
end
