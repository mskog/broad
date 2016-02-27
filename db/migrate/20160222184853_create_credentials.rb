class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.string :name
      t.hstore :data
      t.timestamps
    end

    add_index :credentials, :name, unique: true
  end
end
