class CreateMovieReleases < ActiveRecord::Migration
  def change
    create_table :movie_releases do |t|
      t.string :key
      t.string :title
      t.string :download_url
      t.timestamps
    end
    add_index :movie_releases, :key
  end
end
