class AddIndexMachineNumber < ActiveRecord::Migration
  def change
  	add_index :machines, :machine_number, unique: true
  end
end
