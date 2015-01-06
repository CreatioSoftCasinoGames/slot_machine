class AddMoreProfileUsers < ActiveRecord::Migration
  def change
  	add_column :users, :total_bet, :decimal, default: 0
  	add_column :users, :coins_won, :decimal, default: 0
  	add_column :users, :coins_lost, :decimal, default: 0
  	add_column :users, :current_level, :integer, default: 0
  	add_column :users, :machine_unlocked, :integer, default: 0
  	add_column :users, :percentage_win, :integer, default: 0
  	add_column :users, :num_of_tournament_participated, :integer, default: 0
  	add_column :users, :biggest_tournament_win_amount, :decimal, default: 0
  	add_column :users, :best_position_in_tournament, :integer, default: 0
  	add_column :users, :total_spin, :integer, default: 0
  	add_column :users, :device_id, :string
  	add_column :users, :biggest_win, :string
  	add_column :users, :jackpot_win_percent, :integer, default: 0
  	add_column :users, :total_coins, :decimal, default: 0
  	add_column :users, :gifts, :string
  	add_column :users, :iap, :integer, default: 0
  	add_column :users, :bonus_coins, :integer, default: 0

end
end
