class AddBetIndexBetPerLineToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bet_index, :string, default: 0
    add_column :users, :bet_per_line, :string, default: 1
  end
end
