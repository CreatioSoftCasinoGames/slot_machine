class AddFieldsAssets < ActiveRecord::Migration
  def change
  	add_column :assets, :game_id, :integer
  	add_column :assets, :game_type, :string
  end
end
