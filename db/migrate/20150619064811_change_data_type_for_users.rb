class ChangeDataTypeForUsers < ActiveRecord::Migration
  def change
  	change_column :users, :total_bet, :bigint
  	change_column :users, :coins_won, :bigint
  	change_column :users, :coins_lost, :bigint
  	change_column :users, :biggest_tournament_win_amount, :bigint
  	change_column :users, :biggest_win, :bigint
  	change_column :users, :client_coins_won, :bigint
  	change_column :users, :client_coins_lost, :bigint
  	change_column :users, :client_total_bets, :bigint
  	change_column :users, :total_iap_made, :bigint
  	change_column :distributable_jackpots, :amount, :bigint
  end
end