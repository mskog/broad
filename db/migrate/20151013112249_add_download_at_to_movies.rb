# typed: true
class AddDownloadAtToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :download_at, :datetime
  end
end
