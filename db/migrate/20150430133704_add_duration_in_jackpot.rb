class AddDurationInJackpot < ActiveRecord::Migration
  def change
  	add_column :jackpots, :duration, :decimal
  end
end
