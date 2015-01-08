class RemoveThemeIdMachines < ActiveRecord::Migration
  def change
  	remove_column :machines, :theme_id
  end
end
