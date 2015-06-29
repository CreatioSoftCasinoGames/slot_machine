class CreateGameVersions < ActiveRecord::Migration
  def change
    create_table :game_versions do |t|
      t.string :version
      t.string :device_type
      t.boolean :require_update

      t.timestamps
    end
  end
end
