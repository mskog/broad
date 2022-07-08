# typed: true
class AddMissingIdsToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :tmdb_id, :string
    add_column :movies, :trakt_id, :string
    add_column :movies, :slug, :string
  end
end
