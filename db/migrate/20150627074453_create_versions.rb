class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :version_number
      t.boolean :required_update

      t.timestamps
    end
  end
end
