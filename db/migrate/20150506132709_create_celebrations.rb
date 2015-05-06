class CreateCelebrations < ActiveRecord::Migration
  def change
   create_table :celebrations do |t|
     t.string :celebrations
     t.string :reward
     t.integer :user_id

     t.timestamps
   end
 end
end
