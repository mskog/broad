# typed: true
class AddKeyToEpisodes < ActiveRecord::Migration[5.0]
  def change
    add_column :episodes, :key, :string
  end
end
