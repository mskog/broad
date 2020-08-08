class AddPolymorphicAssociationToNewsItems < ActiveRecord::Migration[5.2]
  def change
    add_column :news_items, :newsworthy_id, :integer
    add_column :news_items, :newsworthy_type, :string

    add_index :news_items, [:newsworthy_id, :newsworthy_type]
  end
end
