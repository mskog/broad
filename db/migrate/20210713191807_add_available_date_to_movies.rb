class AddAvailableDateToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :available_date, :date
  end
end
