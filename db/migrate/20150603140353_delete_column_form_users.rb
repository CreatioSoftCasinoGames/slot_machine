class DeleteColumnFormUsers < ActiveRecord::Migration
  def up
  	remove_column :users, :mini_jackpot_status
  	remove_column :users, :major_jackpot_status
  end
  def down
  	add_column :users, :mini_jackpot_status, :boolean, default: false
  	add_column :users, :major_jackpot_status, :boolean, default: false
  end
end
