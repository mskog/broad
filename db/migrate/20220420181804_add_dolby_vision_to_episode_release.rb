# typed: true
class AddDolbyVisionToEpisodeRelease < ActiveRecord::Migration[7.0]
  def change
    add_column :episode_releases, :dolby_vision, :boolean, nil: false, default: false
  end
end
