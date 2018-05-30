class AddTmdbDetailsToTvShow < ActiveRecord::Migration[5.0]
  def change
    add_column :tv_shows, :tmdb_details, :hstore
  end
end
