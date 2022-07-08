# typed: true
class AddWatchedAtToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :watched_at, :datetime
  end
end
