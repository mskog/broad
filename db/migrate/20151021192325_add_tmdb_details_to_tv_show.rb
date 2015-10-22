class AddTmdbDetailsToTvShow < ActiveRecord::Migration
  def change
    add_column :tv_shows, :tmdb_details, :hstore
  end
end
