class AddTimestampsToMovies < ActiveRecord::Migration
  def change
    add_column(:movies, :created_at, :datetime)
    add_column(:movies, :updated_at, :datetime)
  end
end
