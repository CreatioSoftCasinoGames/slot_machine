class AddLabelToReels < ActiveRecord::Migration
  def change
  	add_column :reels, :label, :string
  end
end
