# typed: true
class AddImdbIdToTvShows < ActiveRecord::Migration[5.0]
  def change
    add_column :tv_shows, :imdb_id, :string

    add_index :tv_shows, :imdb_id, unique: true
  end
end
