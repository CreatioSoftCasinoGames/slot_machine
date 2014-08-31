class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :version
      t.integer :resource_id
      t.string :resource_type
      t.attachment :file

      t.timestamps
    end
  end
end
