# typed: true
class AddWaitlistToTvShows < ActiveRecord::Migration[5.2]
  def change
    add_column :tv_shows, :waitlist, :boolean, default: false, nil: false
  end
end
