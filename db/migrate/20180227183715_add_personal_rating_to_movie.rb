class AddPersonalRatingToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :personal_rating, :integer
  end
end
