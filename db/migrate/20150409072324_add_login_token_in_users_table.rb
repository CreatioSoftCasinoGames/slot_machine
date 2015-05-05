class AddLoginTokenInUsersTable < ActiveRecord::Migration
  def change
  	add_column :users, :login_token, :string
  	add_column :users, :online, :boolean, default: false
  end
end
