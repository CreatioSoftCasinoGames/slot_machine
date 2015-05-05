class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.integer :machine_id
      t.integer :min_player
      t.integer :max_player
      t.integer :min_entry_level
      t.integer :max_entry_level
      t.decimal :seed_money
      t.decimal :time_out, default: 1000000

      t.timestamps
    end
  end
end
