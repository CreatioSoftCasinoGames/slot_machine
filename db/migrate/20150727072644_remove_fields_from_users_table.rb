class RemoveFieldsFromUsersTable < ActiveRecord::Migration
  def up
  	remove_column :users, :diamonds
  	remove_column :users, :bonus_coins
  	remove_column :users, :iap
  	remove_column :users, :gifts
  	remove_column :users, :client_total_spin
  	remove_column :users, :client_coins_won
  	remove_column :users, :client_coins_lost
  	remove_column :users, :client_total_bets
  end
  def down
  	add_column :users, :diamonds, :integer
  	add_column :users, :bonus_coins, :integer
  	add_column :users, :iap, :decimal
  	add_column :users, :gifts, :string
  	add_column :users, :client_total_spin, :decimal
  	add_column :users, :client_coins_won, :decimal
  	add_column :users, :client_coins_lost, :decimal
  	add_column :users, :client_total_bets, :decimal
  end
end
