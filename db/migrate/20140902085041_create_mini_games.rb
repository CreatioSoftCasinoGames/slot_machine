class CreateMiniGames < ActiveRecord::Migration
  def change
    create_table :mini_games do |t|
      t.string :name
      t.text :description
      t.integer :machine_id

      t.timestamps
    end
  end
end
