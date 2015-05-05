class CreateJackpots < ActiveRecord::Migration
  def change
    create_table :jackpots do |t|
      t.string :jackpot_type
      t.decimal :seed_amount
      t.decimal :player_percent

      t.timestamps
    end
  end
end
