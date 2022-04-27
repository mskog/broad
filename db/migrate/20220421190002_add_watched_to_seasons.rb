class AddWatchedToSeasons < ActiveRecord::Migration[7.0]
  def change
    add_column :seasons, :watched, :boolean, nil: false, default: false

    Season.find_each do |season|
      season.update watched: season.episodes.all?(&:watched?)
    end
  end
end
