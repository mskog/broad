class AddWaitlistToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :waitlist, :boolean, default: false
  end
end
