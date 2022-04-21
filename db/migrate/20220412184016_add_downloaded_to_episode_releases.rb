class AddDownloadedToEpisodeReleases < ActiveRecord::Migration[7.0]
  def change
    add_column :episode_releases, :downloaded, :boolean, nil: false, default: false
  end
end
