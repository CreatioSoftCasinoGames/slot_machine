class CreateTournamentUsers < ActiveRecord::Migration
  def change
    create_table :tournament_users do |t|
      t.integer :tournament_id
      t.integer :user_id
      t.decimal :rank
      t.integer :point
      t.decimal :prize
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
