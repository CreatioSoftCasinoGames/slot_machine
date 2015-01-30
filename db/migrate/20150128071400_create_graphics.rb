class CreateGraphics < ActiveRecord::Migration
  def change
    create_table :graphics do |t|
      t.string :name
      t.integer :machine_id
      t.text :description

      t.timestamps
    end
  end
end
