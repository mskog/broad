# typed: true
class AddKeyToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :key, :string
  end
end
