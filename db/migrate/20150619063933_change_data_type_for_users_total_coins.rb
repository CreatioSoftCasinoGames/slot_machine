class ChangeDataTypeForUsersTotalCoins < ActiveRecord::Migration
  def change
  	change_column :users, :total_coins, :bigint
  end
end
