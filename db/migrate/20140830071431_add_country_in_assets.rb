class AddCountryInAssets < ActiveRecord::Migration
  def change
  	add_column :assets, :country, :string
  	add_column :assets, :label, :string
  	add_column :assets, :is_permanent, :boolean
  	add_column :assets, :bundle_type, :string
  end
end