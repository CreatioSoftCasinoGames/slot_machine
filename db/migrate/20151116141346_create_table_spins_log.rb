class CreateTableSpinsLog < ActiveRecord::Migration
  def change
    create_table :table_spins_logs do |t|
    	t.integer :game_id
      t.integer :user_id
      t.integer :bet
      t.integer :win
      t.integer :pot_percent

      t.timestamps
    end
  end
end
