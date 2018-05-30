class AddTmdbDetailsToEpisode < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :tmdb_details, :hstore
  end
end
