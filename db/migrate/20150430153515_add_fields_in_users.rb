class AddFieldsInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :client_total_spin, :decimal
  	add_column :users, :client_coins_won, :decimal
  	add_column :users, :client_coins_lost, :decimal
  	add_column :users, :client_total_bets, :decimal
  end
end
