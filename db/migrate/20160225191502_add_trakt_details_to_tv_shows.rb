class AddTraktDetailsToTvShows < ActiveRecord::Migration[5.0]
  def change
    add_column :tv_shows, :trakt_details, :text
  end
end
