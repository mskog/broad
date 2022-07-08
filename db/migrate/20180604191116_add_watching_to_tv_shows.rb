# typed: true
class AddWatchingToTvShows < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_shows, :watching, :boolean, default: false
  end
end
