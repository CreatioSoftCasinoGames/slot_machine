class AddIsDistributed < ActiveRecord::Migration
  def change
  	add_column :distributable_jackpots, :is_distributed, :boolean, default: false
  end
end
