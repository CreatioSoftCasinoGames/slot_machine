class AddVersionInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :version, :integer
  end
end
