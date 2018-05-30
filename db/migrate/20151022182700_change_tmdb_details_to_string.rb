class ChangeTmdbDetailsToString < ActiveRecord::Migration[5.0]
  def change
    change_column(:tv_shows, :tmdb_details, :text)
    change_column(:episodes, :tmdb_details, :text)
  end
end
