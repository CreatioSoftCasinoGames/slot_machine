class AddMachineNumber < ActiveRecord::Migration
  def change
  	add_column :machines, :machine_number, :integer
  end
end
