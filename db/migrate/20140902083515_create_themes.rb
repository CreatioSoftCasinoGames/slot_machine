class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :name
      t.text :description
      t.integer :game_id

      t.timestamps
    end
  end
end
