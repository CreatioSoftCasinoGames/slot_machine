class ChangeDefaultTypeOfIsMiniAndMajorJackpotSeen < ActiveRecord::Migration
  def up
  	change_column :users, :mini_jackpot_status, :boolean, default: true
  	change_column :users, :major_jackpot_status, :boolean, default: true
  end
  def down
  	change_column :users, :mini_jackpot_status, :boolean, default: false
  	change_column :users, :major_jackpot_status, :boolean, default: false
  end
end
