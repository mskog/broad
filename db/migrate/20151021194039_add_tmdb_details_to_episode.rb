class AddTmdbDetailsToEpisode < ActiveRecord::Migration
  def change
    add_column :episodes, :tmdb_details, :hstore
  end
end
