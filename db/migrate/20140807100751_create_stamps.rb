class CreateStamps < ActiveRecord::Migration
  def change
    create_table :stamps do |t|
      t.string :name
      t.text :description
      t.integer :slot_id

      t.timestamps
    end
  end
end
