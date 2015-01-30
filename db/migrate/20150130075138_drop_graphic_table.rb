class DropGraphicTable < ActiveRecord::Migration
  def change
  	drop_table :graphics
  end
end
