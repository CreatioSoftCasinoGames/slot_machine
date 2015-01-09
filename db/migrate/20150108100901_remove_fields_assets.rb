class RemoveFieldsAssets < ActiveRecord::Migration
  def self.up
  	remove_column :assets, :game_id
  	remove_column :assets, :game_type
  end

  def self.down
    add_column :assets, :game_id, :integer
    add_column :assets, :game_type, :string 
  end
end
