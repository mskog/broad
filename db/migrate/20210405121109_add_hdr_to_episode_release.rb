class AddHdrToEpisodeRelease < ActiveRecord::Migration[6.1]
  def change
    add_column :episode_releases, :hdr, :boolean, default: false
  end
end
