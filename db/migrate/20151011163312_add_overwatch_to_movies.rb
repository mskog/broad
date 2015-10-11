class AddOverwatchToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :overwatch, :boolean, default: false
  end
end
