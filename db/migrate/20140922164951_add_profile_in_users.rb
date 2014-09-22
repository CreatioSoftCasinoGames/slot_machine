class AddProfileInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :first_name, :string
  	add_column :users, :last_name, :string
  	add_column :users, :country, :string
  	add_column :users, :stars, :decimal
  	add_column :users, :diamonds, :decimal
  	add_column :users, :fb_id, :string
  	add_column :users, :role, :string
  end
end
