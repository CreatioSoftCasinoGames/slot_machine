class ConvertAssetsToPolymorphic < ActiveRecord::Migration

  def up
  	add_column :assets, :resource_id, :integer
  	add_column :assets, :resource_type, :string
  	remove_column :assets, :game_id
  end

  def down
  	remove_column :assets, :resource_id
  	remove_column :assets, :resource_type
  	add_column :assets, :game_id, :integer
  end

end
