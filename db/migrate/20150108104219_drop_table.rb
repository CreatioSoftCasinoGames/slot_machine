class DropTable < ActiveRecord::Migration
  def change
  	drop_table :pay_lines
  	drop_table :pay_tables
  	drop_table :reels
  	drop_table :stamps
  	drop_table :themes
  end
end
