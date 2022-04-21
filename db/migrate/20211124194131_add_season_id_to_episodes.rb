class AddSeasonIdToEpisodes < ActiveRecord::Migration[6.1]
  def change
    add_column :episodes, :season_id, :integer
  end
end
