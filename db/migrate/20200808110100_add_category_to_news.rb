# typed: true
class AddCategoryToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news_items, :category, :string
  end
end
