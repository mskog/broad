class CreateSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :seasons do |t|

      t.references :tv_show
      t.integer :number

      t.timestamps
    end
  end
end
