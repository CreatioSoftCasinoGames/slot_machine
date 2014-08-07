class CreatePayTables < ActiveRecord::Migration
  def change
    create_table :pay_tables do |t|
      t.decimal :count
      t.integer :stamp_id
      t.integer :slot_id
      t.decimal :points

      t.timestamps
    end
  end
end
