class CreateEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string :name
      t.integer :season
      t.integer :episode
      t.integer :year
      t.timestamps
    end
  end
end
