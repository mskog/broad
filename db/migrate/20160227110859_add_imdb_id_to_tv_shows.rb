class AddImdbIdToTvShows < ActiveRecord::Migration
  def change
    add_column :tv_shows, :imdb_id, :string

    add_index :tv_shows, :imdb_id, unique: true
  end
end
