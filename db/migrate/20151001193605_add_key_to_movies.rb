class AddKeyToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :key, :string
  end
end
