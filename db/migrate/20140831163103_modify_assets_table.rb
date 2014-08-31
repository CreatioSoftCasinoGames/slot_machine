class ModifyAssetsTable < ActiveRecord::Migration
  def up
  	rename_column :assets, :is_permanent, :active
  	remove_column :assets, :resource_type
  	remove_column :assets, :resource_id
  	add_column :assets, :game_id, :integer
  end

  def down
  	rename_column :assets, :active, :is_permanent
  	add_column :assets, :resource_type, :string
  	add_column :assets, :resource_id, :integer
  	remove_column :assets, :game_id
  end

end
