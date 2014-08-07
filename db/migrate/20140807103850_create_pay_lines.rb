class CreatePayLines < ActiveRecord::Migration
  def change
    create_table :pay_lines do |t|
      t.string :label
      t.integer :x
      t.integer :y
      t.integer :slot_id

      t.timestamps
    end
  end
end
