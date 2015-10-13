class AddDownloadAtToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :download_at, :string
    add_column :movies, :datetime, :string
  end
end
