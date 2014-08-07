class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.string :name
      t.text :description
      t.integer :game_id

      t.timestamps
    end
  end
end
