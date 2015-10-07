class RenameRelease < ActiveRecord::Migration
  def change
    rename_table :releases, :episode_releases
  end
end
