class ChangeMovieReleases < ActiveRecord::Migration[5.0]
  def change
    remove_column :movie_releases, :key
    remove_column :movie_releases, :title
    remove_column :movie_releases, :download_url

    add_column :movie_releases, :movie_id, :integer
    add_column :movie_releases, :ptp_movie_id, :integer
    add_column :movie_releases, :checked, :boolean
    add_column :movie_releases, :codec, :string
    add_column :movie_releases, :container, :string
    add_column :movie_releases, :golden_popcorn, :boolean
    add_column :movie_releases, :leechers, :integer
    add_column :movie_releases, :seeders, :integer
    add_column :movie_releases, :quality, :string
    add_column :movie_releases, :release_name, :string
    add_column :movie_releases, :resolution, :string
    add_column :movie_releases, :size, :integer, limit: 8
    add_column :movie_releases, :snatched, :integer
    add_column :movie_releases, :source, :string
    add_column :movie_releases, :scene, :boolean
    add_column :movie_releases, :upload_time, :datetime
  end
end
