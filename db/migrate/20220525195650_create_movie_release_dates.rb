# typed: true
class CreateMovieReleaseDates < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_release_dates do |t|
      t.references :movie
      t.date :release_date, null: false
      t.string :release_type, null: false

      t.timestamps
    end
  end
end
