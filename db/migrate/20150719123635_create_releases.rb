# typed: true
class CreateReleases < ActiveRecord::Migration[5.0]
  def change
    create_table :releases do |t|
      t.references :episode
      t.string :title
      t.string :url
      t.string :file_type
      t.string :file_encoding
      t.string :source
      t.string :resolution
      t.datetime :published_at
      t.timestamps
    end
  end
end
