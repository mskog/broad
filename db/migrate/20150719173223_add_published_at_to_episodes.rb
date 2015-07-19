class AddPublishedAtToEpisodes < ActiveRecord::Migration
  def change
    add_column :episodes, :published_at, :datetime
  end
end
