class AddTvdbIdToTvShows < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_shows, :tvdb_id, :integer
  end
end
