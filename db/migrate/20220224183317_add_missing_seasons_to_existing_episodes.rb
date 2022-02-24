class AddMissingSeasonsToExistingEpisodes < ActiveRecord::Migration[7.0]
  def change
    Episode.find_each do |episode|
      episode.season = Season.find_or_create_by(tv_show_id: episode.tv_show_id, number: episode.season_number)
      episode.save!
    end
  end
end
