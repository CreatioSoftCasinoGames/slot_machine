class RenamePositionToSize < ActiveRecord::Migration

  def up
  	rename_column :reels, :position, :size
  end

  def down
  	rename_column :reels, :size, :position
  end

end
