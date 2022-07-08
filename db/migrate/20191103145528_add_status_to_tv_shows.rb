# typed: false
class AddStatusToTvShows < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_shows, :status, :string

    TvShow.find_each do |tv_show|
      next unless tv_show.trakt_details.present?
      tv_show.status = tv_show.trakt_details[:status]
      tv_show.save!
    end
  end
end
