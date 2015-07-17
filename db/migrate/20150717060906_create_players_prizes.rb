class CreatePlayersPrizes < ActiveRecord::Migration
  def change
    create_table :players_prizes do |t|
      t.float :prize_pool_percent
      t.float :next_winner_difference
      t.float :user_score_percent
      t.float :player_one_percent
      t.float :player_two_percent
      t.float :player_three_percent

      t.timestamps
    end
  end
end
