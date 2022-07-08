# typed: true
class AddTvShowIdToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :tv_show_id, :integer
    add_index :episodes, :tv_show_id
  end
end
