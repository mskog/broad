class AddDownloadAtToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :download_at, :datetime
  end
end
