class ChangeStarsToBiginteger < ActiveRecord::Migration
  def change
  	change_column :users, :stars, :bigint
  end
end
