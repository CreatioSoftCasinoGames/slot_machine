class AddStatusFieldInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :mini_jackpot_status, :boolean, default: false
  	add_column :users, :major_jackpot_status, :boolean, default: false
  end
end
