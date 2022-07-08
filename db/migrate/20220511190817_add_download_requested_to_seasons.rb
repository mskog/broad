# typed: true
class AddDownloadRequestedToSeasons < ActiveRecord::Migration[7.0]
  def change
    add_column :seasons, :download_requested, :boolean, null: false, default: false
  end
end
