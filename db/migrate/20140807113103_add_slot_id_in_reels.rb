class AddSlotIdInReels < ActiveRecord::Migration
  def change
  	add_column :reels, :slot_id, :integer

  end
end
