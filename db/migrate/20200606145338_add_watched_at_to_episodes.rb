class AddWatchedAtToEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :watched_at, :datetime

    Episode.find_each do |episode|
      next unless episode.watched
      episode.watched_at = episode.updated_at
      episode.save!
    end
  end
end
