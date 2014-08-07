class CreateReels < ActiveRecord::Migration
  def change
    create_table :reels do |t|
      t.integer :stamp_id
      t.integer :position

      t.timestamps
    end
  end
end
