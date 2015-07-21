class AddKeyToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :key, :string
  end
end
