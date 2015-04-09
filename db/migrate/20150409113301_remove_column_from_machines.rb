class RemoveColumnFromMachines < ActiveRecord::Migration
  def up
  	remove_column :machines, :timeout
  	remove_column :machines, :seed_money
  end
  def down
  	add_column :machines, :timeout, :decimal, default: 1000000
  	add_column :machines, :seed_money, :decimal
  end
end
