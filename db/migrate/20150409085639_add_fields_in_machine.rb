class AddFieldsInMachine < ActiveRecord::Migration
  def change
  	add_column :machines, :machine_type, :string
  	add_column :machines, :min_players, :integer
  	add_column :machines, :max_players, :integer
  	add_column :machines, :timeout, :decimal, default: 1000000
  	add_column :machines, :seed_money, :decimal
  end
end
