class AddDownloadAtToEpisodes < ActiveRecord::Migration
  #:reek:FeatureEnvy
  def change
    add_column :episodes, :download_at, :datetime

    Episode.find_each do |episode|
      episode.update download_at: episode.created_at + ENV['DELAY_HOURS'].to_i.hours
    end
  end
end
