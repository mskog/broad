class AddTmdbImagesToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :tmdb_images, :jsonb, :null => false, :default => {}
  end
end
