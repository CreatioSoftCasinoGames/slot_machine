class AddGameIdMachines < ActiveRecord::Migration
  def change
  	add_column :machines, :game_id, :integer
  end
end
