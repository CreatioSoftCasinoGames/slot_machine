class CreateDistributableJackpots < ActiveRecord::Migration
  def change
    create_table :distributable_jackpots do |t|
      t.integer :jackpot_id
      t.decimal :seed_amount
      t.decimal :player_percentage
      t.decimal :amount
      t.boolean :active, default: true
      t.integer :winner_id

      t.timestamps
    end
  end
end
