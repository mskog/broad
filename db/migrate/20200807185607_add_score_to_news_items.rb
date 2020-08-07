class AddScoreToNewsItems < ActiveRecord::Migration[5.2]
  def change
    add_column :news_items, :score, :integer
  end
end
