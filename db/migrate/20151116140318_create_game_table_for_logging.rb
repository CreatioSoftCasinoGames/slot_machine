class CreateGameTableForLogging < ActiveRecord::Migration
  def change
    create_table :game do |t|
    	t.integer :tournament_id

      t.timestamps
    end
  end
end
