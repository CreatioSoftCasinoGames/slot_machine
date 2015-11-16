class CreateGameWinnersTable < ActiveRecord::Migration
  def change
    create_table :game_winners do |t|
    	t.integer :game_id
      t.integer :winner_id
      t.integer :rank
      t.decimal :point
      t.integer :prize

      t.timestamps
    end
  end
end
