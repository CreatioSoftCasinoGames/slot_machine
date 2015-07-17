class ChangeTypePlayerPercentInJackpot < ActiveRecord::Migration
  def change
  	change_column :jackpots, :player_percent, :float
  end
end
