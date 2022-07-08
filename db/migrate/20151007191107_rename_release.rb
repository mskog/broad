# typed: true
class RenameRelease < ActiveRecord::Migration[5.0]
  def change
    rename_table :releases, :episode_releases
  end
end
