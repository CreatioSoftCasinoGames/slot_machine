class CreateGiftRequests < ActiveRecord::Migration
  def change
    create_table :gift_requests do |t|
      t.integer :user_id
      t.integer :send_to_id
      t.boolean :confirmed, default: false
      t.string :gift_type
      t.decimal :gift_value

      t.timestamps
    end
  end
end
