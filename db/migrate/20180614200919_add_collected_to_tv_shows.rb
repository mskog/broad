class AddCollectedToTvShows < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_shows, :collected, :boolean, default: false, nil: false
  end
end
