class AddAirDateToEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :air_date, :date

    Episode.where.not(tmdb_details: nil).find_each do |episode|
      episode.air_date = episode.tmdb_details['air_date']
      episode.save!
    end
  end
end
