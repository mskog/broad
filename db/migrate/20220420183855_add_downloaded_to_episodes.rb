# typed: true
class AddDownloadedToEpisodes < ActiveRecord::Migration[7.0]
  def change
    add_column :episodes, :downloaded, :boolean, nil: false, default: false

    Episode.where.not(download_at: nil).update_all(downloaded: true)
  end
end
