class AddTvShowIdToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :tv_show_id, :integer
    add_index :episodes, :tv_show_id
  end
end
