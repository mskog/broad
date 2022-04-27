class AddDownloadedToSeasons < ActiveRecord::Migration[7.0]
  def change
    add_column :seasons, :downloaded, :boolean, nil: false, default: false

    Season.find_each do |season|
      season.update downloaded: season.episodes.all?(&:downloaded?)
    end
  end
end
