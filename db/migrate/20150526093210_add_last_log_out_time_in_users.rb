class AddLastLogOutTimeInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :last_logout_time, :datetime
  end
end
