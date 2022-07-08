# typed: true
class ChangeSeasonToSeasonNumber < ActiveRecord::Migration[6.1]
  def change
    rename_column :episodes, :season, :season_number
  end
end
