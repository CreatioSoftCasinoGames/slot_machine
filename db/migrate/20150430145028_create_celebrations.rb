class CreateCelebrations < ActiveRecord::Migration
  def change
    create_table :celebrations do |t|
      t.integer :four_of_a_kind, default: 0
      t.integer :five_of_a_kind, default: 0
      t.integer :big_win, default: 0
      t.integer :mega_win, default: 0
      t.integer :ultimate_win, default: 0
      t.integer :user_id, default: 0

      t.timestamps
    end
  end
end
