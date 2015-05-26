class AddTotalIapMadeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_iap_made, :decimal
  end
end
