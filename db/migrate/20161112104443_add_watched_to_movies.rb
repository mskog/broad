class AddWatchedToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :watched, :boolean, default: false
  end
end
