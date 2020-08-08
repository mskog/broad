class AddMetaDataToNewsItems < ActiveRecord::Migration[5.2]
  def change
    add_column :news_items, :metadata, :json
  end
end
