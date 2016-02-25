class AddTraktDetailsToTvShows < ActiveRecord::Migration
  def change
    add_column :tv_shows, :trakt_details, :text
  end
end
