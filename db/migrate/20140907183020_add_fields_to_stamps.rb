class AddFieldsToStamps < ActiveRecord::Migration
  def change
  	add_column :stamps, :symbol_type, :string
  	add_column :stamps, :size, :integer, default: 1
  end
end
