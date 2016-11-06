class AddWatchedToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :watched, :boolean, default: false
  end
end
